Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF440C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9784220896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 20:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9784220896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936405AbeFOUhf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 16:37:35 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:43950 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936295AbeFOUhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 16:37:32 -0400
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w5FKbWX0019529
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:37:32 -0400
Received: from mail-qk0-f200.google.com (mail-qk0-f200.google.com [209.85.220.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w5FKbRvt020695
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:37:32 -0400
Received: by mail-qk0-f200.google.com with SMTP id g2-v6so8886804qkm.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 13:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=QsO8U5UCExfeQ1Jh8K4XfbcjDpaiJIIryELDY0XWM2U=;
        b=qL4KXTNqtO0zEOpp27eTgQ85urxtY5pnPSVDdrKGnSjn49WDJyYSMV0HvQ0sqxRmVU
         1HFRQBh8vUypA2in/fNlIWcN4q/J6GZbSukP7OkuuTU4Rh3ewb7H09AeCiU2JZrRevTn
         jTXp1qL/LFxMacifvJGarhhFDLGBOeFpK522PT6kmLLvRCF+eiBawTEKxbT6hyKER3Xr
         TdIohyL/gm2FDzVhwGGooU+GS+AggpmIDSgz76eT3HgF9noQ70hvn2GDexB2lSPhBHmo
         tBN0E1mDVl0rdGE/8chX3a6+DtHgX0Hoizzjqh868aC4JErS52UCwMA84s12ISbHWZB9
         wFtg==
X-Gm-Message-State: APt69E3yxiMtjOQs4Vqr1WQSN3TTFkbC9EcNmRLMiY0TRQRBiFSyAWv1
        O5oEeKtAs71XnRkyhs0wvYklZ8SQ9KuoA7uO74jZdopbNSyKuwhAQGe94z69zfyi7xGhhIYGQTY
        YDRYkz7H8G0u+UeEE9yyTlUacmRLdotERd10=
X-Received: by 2002:ae9:d615:: with SMTP id r21-v6mr2762528qkk.135.1529095046975;
        Fri, 15 Jun 2018 13:37:26 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKJeNnDKZjW9n3lxA8OJuDyrk4dhwzPeHy7emJ/0zU/ORlpO9rRw2CQkR5BY7bnqXjCaZ1m97A==
X-Received: by 2002:ae9:d615:: with SMTP id r21-v6mr2762501qkk.135.1529095046716;
        Fri, 15 Jun 2018 13:37:26 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:c5a7:bb98:8d38:c9af])
        by smtp.gmail.com with ESMTPSA id g18-v6sm7325129qtg.59.2018.06.15.13.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 13:37:25 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "malat@debian.org" <malat@debian.org>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
In-Reply-To: <33eec86a35248e5b20f15bb568641b9affcc0a9b.camel@wdc.com>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org> <1528455990-24572-2-git-send-email-sayalil@codeaurora.org> <20180612192636.GA31725@rob-hp-laptop> <000101d403d3$87210d20$95632760$@codeaurora.org>
 <33eec86a35248e5b20f15bb568641b9affcc0a9b.camel@wdc.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1529095054_2750P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jun 2018 16:37:34 -0400
Message-ID: <95985.1529095054@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1529095054_2750P
Content-Type: text/plain; charset=us-ascii

Actually, it makes it easier to follow the conversation.

On Thu, 14 Jun 2018 13:35:08 -0000, Bart Van Assche said:
> On Thu, 2018-06-14 at 17:03 +0530, sayali wrote:
> > Comment inline.
>
> Hello Sayali,
>
> Please don't use inline replies. That makes it very hard to follow the
> conversation.

Actually, it makes it easier to follow the conversation.

> * If IMAP has been enabled on the Exchange server that you are using then
>   that means that you can choose from the many open source e-mail clients
>   that support IMAP.

Which of the two is easier to follow?


--==_Exmh_1529095054_2750P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWyQjjo0DS38y7CIcAQIQLAgAp4CV2ml7V5VMI6ixb1ZY/6ZfY95RvdNx
RWUKlkwzqUUCX6GLRYPPWGn0wa4QXL9/zbT2vQSRMH0L6vRvE1QkVAwYWm0jzC/A
yrCIBsJQlS3PG/6FcqbO240nAtqbCASHlgCWPPD+KvjDmifI21s5d5DzsRR6zzGN
bw/8Asd7Sr8hhyhNxqb0Axsi4sVvdg5pmGqRAtBXC47B/eB9x56ESf/PaemsgjTx
RJ98C2HlRirF9rwcq13x1Ippk+hIEQdzUx8Taay90Pf5oB9z2h3/Pi5/tGo2gOO2
+uoJx+tNUnGrjdgj8lAILryYKotWOhlgJ+H1S10kOvttemxq1l1BBQ==
=YF+i
-----END PGP SIGNATURE-----

--==_Exmh_1529095054_2750P--
