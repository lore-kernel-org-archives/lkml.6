Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527155070-2-1790215294309701785
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155070; b=AoGL7BXdI3T63hmQTPTJIg2oHJqSmsYd8l757s8KbqK2SaBwHT
    qiJgMngsjbmghIo5FB3HP+5eoVU7T7OlrW4NVMbXmOTy1ZlKl1EaaXEAVEoxsKTi
    dR81fNwGeo3KeU/uE7rd01UGuypXne2xirJ7VNgVbKRuhRlCnIV/QslwDqXtd7x7
    nQouSzT/VsRPgJI8kHQt5yX+ArtWELO1MidDvZY4UaCE7zMCqw42r6QhCrT9vF21
    mFSvkk1U2vUkbMgd+gOincohxWUf90tRZBoO+sEM5WtmUoZjjvJKOTdr6RnLQWUR
    HfBMQnKB+94yIDaiZ18/+ygftn2rnINpn/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155070; bh=ImOpb9IsXwZrPqy2oJryP+YuBx6WND
    TXFcUNOGqJAYk=; b=e5FWtzkv9IjM66NKag4vQytYflAmc049Kn3XS22QkX7C/G
    9rx1M2Xcb1FVKPBWuijtI/j66yV2fo4jqe2aOEwmzvXpebaecLM+BIQssL4YMt4T
    guZj7tJmFrSovc3JwTmONAV/mN1qfjv3nKmasJHVlICvRIAStULVUfCqDqf3rNMA
    DOo7LPanyqEHx4wMQ1aha1pZcWjl5xdvrrwjw363m4VvbGhtWDNY1zBY08CeoF1V
    P7tSS8/mDmqvW7sJeRX6NDafa4480q382mBM0CdTTMys5nFOAfZmgT+U79P0Tcqs
    64bbBBc2t+TBcwYI/lL/nI1kIq6oJindWBlB+1DQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=E0or0X8K x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=E0or0X8K x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMlCi1ZvN3l2ZxR69qdPcJvQpPGTvXnXTKZt0SYs3geQeFSOOKRWDKCkFhFZ9Ym25G//hVdF9eRiAVQHzk5ClmQCWhD9FAiSTHzJLYy5cGWuisbbi0Yg
    EWmOjc3SnNUdDZMU7VpZtqzuf5sjo1xXw/PkWcH1YcNEHcSqCY/sFXggmP6ghUeFS6GErIqMYEHOaZEMX0FT9IZjqZvEhfxkV89geQe9JFcRZ+DrUa9C68SE
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=7J7wI5G0n_s90aWr2ecA:9
    a=30-BdaIwVeb55H2E:21 a=oarUXJnYZj5-zp8d:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966642AbeEXJo2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966176AbeEXJoX (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 40/92] ALSA: control: fix a redundant-copy issue
Date: Thu, 24 May 2018 11:38:17 +0200
Message-Id: <20180524093202.831019751@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenwen Wang <wang6495@umn.edu>

commit 3f12888dfae2a48741c4caa9214885b3aaf350f9 upstream.

In snd_ctl_elem_add_compat(), the fields of the struct 'data' need to be
copied from the corresponding fields of the struct 'data32' in userspace.
This is achieved by invoking copy_from_user() and get_user() functions. The
problem here is that the 'type' field is copied twice. One is by
copy_from_user() and one is by get_user(). Given that the 'type' field is
not used between the two copies, the second copy is *completely* redundant
and should be removed for better performance and cleanup. Also, these two
copies can cause inconsistent data: as the struct 'data32' resides in
userspace and a malicious userspace process can race to change the 'type'
field between the two copies to cause inconsistent data. Depending on how
the data is used in the future, such an inconsistency may cause potential
security risks.

For above reasons, we should take out the second copy.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/core/control_compat.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -400,8 +400,7 @@ static int snd_ctl_elem_add_compat(struc
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
 	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
 		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
+	if (get_user(data->owner, &data32->owner))
 		goto error;
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
