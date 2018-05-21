Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937564-2-3834429239370727167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937563; b=DyB9WOxXSYJC2KTFjxSoviCu7TvqrZ2Wgj8uthpG6zb5gaMWG4
    lIsISppRqB0GndyDdX0DUI7uOJVbgkTt1kxnFiDsZmaQpA/tsRl++L34l3tg+2OR
    vMNp0XAc3yYn2ghAQZPe6mfboiSdwDMbfMOKJhJXovbv3aL0GwDo9E76Ieh667J1
    A5BnzP5hJHUMSraLEF7jNlxkVsMW9HFilGQhFyPuMhphtVX6ltBVdgv5G2bdKK7S
    MqZXfS01UI+tz8++qBhRMym5AXvoJQ02Sx85+FCLp6PHVB/4JPddN8+qM2gxwUyC
    cHxiRnAf9GN27vh1JnqoIY1pVvK5G4XnImSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937563; bh=bK+ANZ5gJDqKhZg8QGHvLzeQ5+r6fQ
    mLIhyCzwhKiXk=; b=VJnGp/POZNIpJM/1T2sCsUAUB1ljENlbru905b9BCaovOA
    4rrniUT4jPOZxOqnK4F/CFHcN5BdKWwef12QNzUP5lfSyjcMLwmH6NzeRYyzhbqS
    bFEPMb6n7jp0fS2CmR+UWPzXu9jx1zA+9WWOf+gT5l+/GkFSC9Zz0sltyLBzlUjy
    WokeQ5uhdJSXYTqDWE08gV1SKSRjOJjaqTHUnhBEhkjuneGhEBkJVJKKABcahooW
    /Wsvh34ORoybRjLefpVwHJp7wyVc4DE5ltYhIpxWwnSBlxYlfYQeXOKkz2riYnKD
    VJRqcIttHVmmTR36W2JJVTdVoThuKixRLahoCV1g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Ke1KCs/w x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Ke1KCs/w x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFYVk/WH/Xffpz+96FFdja4nRDuhoApjV1jTBCYU20sfozDqAa6YMkQrEUgorVT9LZgbio/S+aFdTHF8cOS7mV9IyR7ogLevpyUTMucFcm3i2CUteQp7
    /m5xRZeVThHm73chuOWIAtsXFq7IoycU0C6063FawZX0qaFTL1iIr+XVLHgCMGuwgPoLyJo4ndhYc0+HM9Hgab0azHROb3ldsRvd/DpaL7YLYIdUOAqS2897
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=7J7wI5G0n_s90aWr2ecA:9
    a=6aqBm-lsDSLTv4n4:21 a=oarUXJnYZj5-zp8d:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeEUVTV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753713AbeEUVTO (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:19:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 08/95] ALSA: control: fix a redundant-copy issue
Date: Mon, 21 May 2018 23:10:58 +0200
Message-Id: <20180521210448.999627759@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
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
@@ -396,8 +396,7 @@ static int snd_ctl_elem_add_compat(struc
 	if (copy_from_user(&data->id, &data32->id, sizeof(data->id)) ||
 	    copy_from_user(&data->type, &data32->type, 3 * sizeof(u32)))
 		goto error;
-	if (get_user(data->owner, &data32->owner) ||
-	    get_user(data->type, &data32->type))
+	if (get_user(data->owner, &data32->owner))
 		goto error;
 	switch (data->type) {
 	case SNDRV_CTL_ELEM_TYPE_BOOLEAN:
