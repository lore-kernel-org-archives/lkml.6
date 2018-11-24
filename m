Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,TVD_SPACE_RATIO
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECE5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D71D2086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 12:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6wsL/mm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D71D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbeKXXYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 18:24:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46457 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeKXXYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 18:24:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so11941323oif.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 04:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zFR3r1W60VBMNXtOeygWK78I+Q7v+A1jwk9YY4goEsM=;
        b=S6wsL/mmVtpIw8KyAquWbDz/Z+T/wPT8/YNUrRhZauaXUV3yF0XXQzAMAxsX4bIkOR
         SmkWyA7K/NjIjGg8HOmP1Ah9NR9lvxPNcdITY0Y39G2diEJnIOpWTWb9cPvWGF3aXqPW
         yeD1cG88f97rV/6DpCnFaxfJa2Gf0QCymxiX/4KPK1iUo4WToLMFmSbt82Oa0kBS6Y8c
         CkUJ+ZOBlFr2nPlOv0KJt1VzgpjU7cJczZTXlLLNcXZOHU7aLmelbTlLi/BHLeFb+y4L
         5Yo7muQxIUMAokZlSIkIPkUaK9cs9l0BtLWAdPwS+mezUvvNmFFuRqNqrq2y16RmjhCx
         qLVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zFR3r1W60VBMNXtOeygWK78I+Q7v+A1jwk9YY4goEsM=;
        b=pFmzBcigHzyB5CDhdgt9BjeotLpg+czL7O9yU0N4764xl22ywwBtKBlCuUHLUho5S1
         Vyuaxw7hTkk4bLXdwxyBIUIUiA3ms4q3bQbjdt3sQFWzL0L98QIjnhmbWJNsCOep3GH6
         lDlO/nWZeqQ1/OiRkqjDDNxgFOAAGP8/oGz8pEZNZOiYQ7xA2tSs+PCfohGydhD40Uan
         JYJQvmTYYarC7Pv+3br8IA5uaDm4+ajLSJxZN9F83zwa/mxaAclhZtdeifUG1ycfDO5y
         Q30MtfbzDMuv8yjKdoJotLtxXdgDJjogVDzqbKnSIIu5rn5q+KII/yo/VjdS8qfQL7IK
         mAFA==
X-Gm-Message-State: AGRZ1gIEOUawsn2KQlXN66Hf6YQTzStHO1rRe8ALWU4TVZDOxx+3ye0N
        zRrr+uwgkQWpQ6G4aipr3uOcaIVeW8LZNpVYQkG6SHNh
X-Google-Smtp-Source: AJdET5fFpH+VZDDNocMYbC5eisp5xBb8+nh12715e0fPcsdBIUOJguf1Iy82y23WuNqje1uYUUM4M25HlKDyzt1ZmUg=
X-Received: by 2002:aca:4709:: with SMTP id u9mr10132612oia.212.1543062954765;
 Sat, 24 Nov 2018 04:35:54 -0800 (PST)
MIME-Version: 1.0
From:   David CARLIER <devnexen@gmail.com>
Date:   Sat, 24 Nov 2018 12:35:43 +0000
Message-ID: <CA+XhMqyR1wMEnEE2cCnoGj2RatxTbFuNH2jOj1-50iYso67rAw@mail.gmail.com>
Subject: [PATCH] Little memset_explicit optimisation
To:     linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, aryabinin@virtuozzo.com
Content-Type: multipart/mixed; boundary="0000000000004935e3057b685763"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004935e3057b685763
Content-Type: text/plain; charset="UTF-8"



--0000000000004935e3057b685763
Content-Type: application/octet-stream; 
	name="0001-memzero_explicit-optimisation-for-size.patch"
Content-Disposition: attachment; 
	filename="0001-memzero_explicit-optimisation-for-size.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jovfqot30>
X-Attachment-Id: f_jovfqot30

RnJvbSBjNmJiNzU4OTAyYjNiMzU4ZGU5YTk4YmI0MTU2YzMwNjY4NWY1OWQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBDYXJsaWVyIDxkZXZuZXhlbkBnbWFpbC5jb20+CkRh
dGU6IFNhdCwgMTcgTm92IDIwMTggMTQ6MTM6MTMgKzAwMDAKU3ViamVjdDogW1BBVENIXSBtZW16
ZXJvX2V4cGxpY2l0LCBvcHRpbWlzYXRpb24gZm9yIHNpemUuCgpVc2luZyB0aGUgcmV0dXJuIHZh
bHVlIG9mIG1lbXNldCBmb3Igc2F2ZS9sb2FkIHNha2UuCgpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBD
YXJsaWVyIDxkZXZuZXhlbkBnbWFpbC5jb20+Ci0tLQogbGliL3N0cmluZy5jIHwgMiArLQogMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
bGliL3N0cmluZy5jIGIvbGliL3N0cmluZy5jCmluZGV4IDM4ZTRjYTA4ZTc1Ny4uOTJkYTA0YTAy
MTNiIDEwMDY0NAotLS0gYS9saWIvc3RyaW5nLmMKKysrIGIvbGliL3N0cmluZy5jCkBAIC03MjAs
NyArNzIwLDcgQEAgRVhQT1JUX1NZTUJPTChtZW1zZXQpOwogICovCiB2b2lkIG1lbXplcm9fZXhw
bGljaXQodm9pZCAqcywgc2l6ZV90IGNvdW50KQogewotCW1lbXNldChzLCAwLCBjb3VudCk7CisJ
cyA9IG1lbXNldChzLCAwLCBjb3VudCk7CiAJYmFycmllcl9kYXRhKHMpOwogfQogRVhQT1JUX1NZ
TUJPTChtZW16ZXJvX2V4cGxpY2l0KTsKLS0gCjIuMTkuMQoK
--0000000000004935e3057b685763--
