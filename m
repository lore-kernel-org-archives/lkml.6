Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839936-2-5388418330374819008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524839936; b=cxFA5N/e+NPLfK/Qa9yi9xy4Inei558gshFuYDGmK5xtb/u6Qv
    CokCgGlhdwBHpvdHlL8cI4ebCt+b1msWmndZy6fO75HeZZ+AjhWdBf1Br7QINQhb
    BmcbOKjthpcmxd6g3bUzVI9pnxRSwGl4PoE9Csvvezp7WNl5n6ucbRtNNbpbKyBV
    ubMds12IhlBI0Uttgx1HhN3HgLJ08huk/51+1hm1+R/kmKr3Kfy4Xy82wFG+JWCf
    2YLy9KgLf5R2SOjWg6h0aAsyAwmdk7iTHufwRug4oDStBX04wQuN+DWkKQV353Wl
    xiy6b48JJPeT2Bb72NghoaP7OzL0e3JFzB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839936; bh=Y5hllztLpPzzYOA+6X9Q9LZFZshtXo
    g75PN0R4guyu0=; b=kufc88OngUjpPnZhvyq4kGP80Zd274TMC8AnGqVW60SAUo
    HkIeUGzEYkpCXTPgE3QIwgMniigCWjKZTdsQYYPMmlfx1fQSN66Zjga8uYBq+WI7
    RHafzoo3CsJUUWbNcJtysWEGjpOxwaBy3UuzP7SRffObybSzaWtMrIsRFGcdoPTn
    PIyfzjRS6dMB1/6KbxOIsX661YRtfyFQA9BmyRKrsqDB22+IEUFLMzPt0p8HbEub
    6SqoGD3NhmKXYtqWgQKuLm9XM/JuADni5MM/I4glrjqwupMGPpzvgS80aiCh2tbF
    moAYLLObSE3R/NjUnvBcdiJVSNgP/25GZZOsQH6Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPkrbfFVsktH30n0grvFFBgmwKH0RahVhbfL+lZfgs/sOtceRMRx4cr5x82VZnZhmhtZfbzNb8GJ497eF9KYeY9evxxThclQNLhP3tfYd68cy64T2mSH
    4bVEK0q5wcXnzIj8n6HccTF0+ZAoQ/Kn9ck4OW2sWie4fMC7t0kH1BygckGiAyBruIi0DZHyDNelVvqh5TRGulueMQ64+ipO3yOwp4ZZPat9GjGCc0yJHQu2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=ag1SF4gXAAAA:8 a=UwytntJV3dstgXyDF5IA:9 a=QEXdDO2ut3YA:10
    a=o72u2rHnfW5qNJ_4I8LD:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934629AbeD0Oik (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934625AbeD0OJK (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA5D21892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4.14 73/80] block/swim: Select appropriate drive on device open
Date: Fri, 27 Apr 2018 15:59:06 +0200
Message-Id: <20180427135736.699960388@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135732.928644313@linuxfoundation.org>
References: <20180427135732.928644313@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit b3906535ccc6cd04c42f9b1c7e31d1947b3ebc74 upstream.

The driver supports internal and external FDD units so the floppy_open
function must not hard-code the drive location.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -646,7 +646,7 @@ static int floppy_open(struct block_devi
 
 	swim_write(base, setup, S_IBM_DRIVE  | S_FCLK_DIV2);
 	udelay(10);
-	swim_drive(base, INTERNAL_DRIVE);
+	swim_drive(base, fs->location);
 	swim_motor(base, ON);
 	swim_action(base, SETMFM);
 	if (fs->ejected)
