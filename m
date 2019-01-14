Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FF2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A5720663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="j4uJsbIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfANHke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:40:34 -0500
Received: from mout.web.de ([212.227.15.14]:58897 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfANHke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547451631;
        bh=RYCr1/aBme6Nfwk/Mc3fhQr/GUMWVKxKJGzltdC0vAw=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=j4uJsbIFfF0UDurk3pJemWbkVkt6PIUVP4f8lbipHv9iQTxvnYc4it+THguY7P1Al
         7o2mUpYa7Vmy3FO3nHBb7brdY29ZHvQOu1y6oPUlOJBiFvdeZTXvnAhsfU4ozNtcff
         FhoVSJYtyPAAeqqyWUbuI9rTTgWeyv9/gb8WB9LA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.11.45]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Ma2V5-1gy8Bt42UZ-00Llgb; Mon, 14
 Jan 2019 08:40:31 +0100
To:     kernel-janitors@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: Generating identifiers similar to UUIDs but without dashes
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c7463786-82f1-01c8-7f47-e784f2602209@web.de>
Date:   Mon, 14 Jan 2019 08:40:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:axa0JXOmhLkAOtNcjEJXrYdc2PQcEsB2afwfzbVeKRMvswHBB0Q
 oqYG3H6K3Usm4AcAqUOUIBMywDBBttIVXi3pLBrYLEPT5U2CVjr7UFROb7Do3Jo5tiXopsa
 3nW0QpaxVna8zPZ4gy7mVWEXEz6zW3qzbZxhdRHxecZzG5oA9OiJ7Xm/yVDPceXnbOBbJqv
 4DqYM0WkxYrspzH8zf8qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gdYqoPenzvs=:o4V2Edv9TCD/YNOwM5ko0J
 D2LMv+pVK3FXJyrW3zLe6jJ6FsQ+duqUTyyNr9k4WJTB9ObMqCJZNcvUqH867U1RP2FfUkMxP
 agVUzj982+32ixETu0nSoKaOcHsHB6prKLPXQHLoagni2een3239ExOtOJb48awvjP/cWLDxj
 JJqtLVhPweMkyLGCqDLEAlclo7J+L0ptLzvNnuI4SmXU06TIEDEIgca2dlj1iKZoPUTvbwZ8t
 gR5ha6B7h8Ul4NmWXDDopr2U6iTdZxm4tJP5Mkw4hCWFTH1U24y7kyl1cWMyWB8kk8anhZVNE
 YwFOYVeXCV4oRARDRFrat373q1Tx0PvMXDK0f+eVOaRCfDdiN7MSSKT+cO/Jjak/NOG4g8hIx
 cx/3VgdzeQkmHs/vN+1VNmdVOanAizjmlszhs17mgiHJV5/l7JXhBz1afG7Pc8R44e6iOZDnL
 bxucHcKHVSw1/W/7CUFf0hM+AaJoMqKlZ98YHBT8RToIcMZO71WcvZo4swoIRm+GY/JkTv8MJ
 LRguEVPZtv+oAIYolTVCoXtDCMPOdlqTrNiNPmqQzrngnBoQWj2mjFQZ3a62Ey0IJ+2ZK45sK
 E7EBuFdpuEcfho4kK31O6tBZQPOMmZl0V+yVPSs0ssfDi9f9/zgz0aP319BXW+8Z2+3VhEAF3
 ie0iJLolsF4iERd6hrjy3FKlo1wwsuQLSWWXkbcZPKtW1k58625vukG+RpBtU7GvDOQlt/AHA
 VUlKATRy9ZI/I77xGOdpI9EC+c/zQfW2whLpez5ynbRC0zXmoblsu+iuf6JhtmWhaYXama+Vi
 WTPjzqnp2rkJ02sn1Lm1S3qR0APt4HQ7CyUvHKSWEb+uRzOPUusUh8a5zaCjH/Dp8abvaHGuj
 F5dfPWak0S/bL6UtvdGNYPjAv3/l2G3VjaN4QG97F1gO4f9nIf7aJyTjEfb0KDk+pldtBCGiI
 zVYNMCd2peg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The file “/proc/sys/kernel/random/uuid” provides a bit of useful data.
The formal definition of the string representation for universally unique
identifiers requires the use of four dashes for the concatenation of fields.
https://tools.ietf.org/html/rfc4122#page-4
https://stackoverflow.com/questions/24481801/is-uuid-without-dashes-hyphens-valid#answer-24484051

Now I am looking again for possibilities to generate reasonably unique
identifiers also without these dashes.
Can any data processing benefit from the avoidance of such extra characters?

Regards,
Markus
