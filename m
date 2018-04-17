Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981082-2-17439897923494977113
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
    1523981081; b=dGBtUP8RV7eXqqGGNyKWM48txlj7KCCV/a6o+HCYJpcFmusIw8
    NXBBbJC73/0Hi/GqVbToLSaufkMR8oA0EhqokHVPA+SnyRwvi4g4p7Y8GA1fLIpm
    DLWm+pfc7Y0YdpW30V/pkK94EMTYw6QQif4gStVwTof5pjXsJmAdt49KO65QDogi
    ZeEmO8GteaDDZOD1UGbQalmdn3h25aairtqBKNX4wpDFwZnYQ3T5d0Nc1LWvrgfv
    C+jWdlPPsDyb7Qvrcmm+SJq1gZ9cnh8cVAYPFerZn1gDXU2iGw8Dv57ubM4TDo61
    gByDH/mvtsWQzV3GSG1iy2vYb08vH2ewc0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981081; bh=TTKR7rGp3S/d5WDcSSG7rVQzU/sSEE
    +M16za5+v4rMU=; b=pVUNEC7FZLmgnFWSwx3Ji+vrs+44ea6nDKGZVIpZNmPwyb
    HOKv1NaofHzM9avKe6EdOTTa2BsWnPcDRgHKGPtE2IPbGEJZEYehYKwZY/UBewUc
    +HzeWnUopecyHd8PEgZxaBDR8y7iaw54sZptD7Z13BhMO4FnDE8N9oRH3wXZX173
    0hPThF7a1BxeGhLK+Mdm6mSGWWaLigYdUflAAcry3gTe0n0BDOWqXiX0qt8s7ZP4
    X4OPzJLDCbOl3gV9LlBeS/EeSTVwisoyetxJTAheHvq7o15aycqiikkzlSCJq54W
    nQQbzy9LHuoGV+0HaUjR2A1Np/pMqWBktJvKpMYQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfFF7Ro3shcdKfT7x/kz0ZnFTNyScjHuRDRqM3/PT3PRODZjznmMrMdnNJk7CFT/Lxt2eRKXjeYuFA42ks3lPT49lCxELVH0MN000Qb+5Maopf89BXXXI
    vNGD1oskcO+cRht5lyRatGpSffqxcYbTyIQIgIP/wc3Xxz6wsQEmXrm9XXnBn+nTiQVjcJwFE4pIoRDu53B0TfcQe4oToiHSMWin7ZiuFgBJUGQYa2IPVMrp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8
    a=fHpiLzcveENg-rVR2RkA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754500AbeDQQEi (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:04:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34224 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754496AbeDQQEh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:04:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.15 33/53] ovl: fix lookup with middle layer opaque dir and absolute path redirects
Date: Tue, 17 Apr 2018 17:58:58 +0200
Message-Id: <20180417155724.756173533@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 3ec9b3fafcaf441cc4d46b9742cd6ec0c79f8df0 upstream.

As of now if we encounter an opaque dir while looking for a dentry, we set
d->last=true. This means that there is no need to look further in any of
the lower layers. This works fine as long as there are no redirets or
relative redircts. But what if there is an absolute redirect on the
children dentry of opaque directory. We still need to continue to look into
next lower layer. This patch fixes it.

Here is an example to demonstrate the issue. Say you have following setup.

upper:  /redirect (redirect=/a/b/c)
lower1: /a/[b]/c       ([b] is opaque) (c has absolute redirect=/a/b/d/)
lower0: /a/b/d/foo

Now "redirect" dir should merge with lower1:/a/b/c/ and lower0:/a/b/d.
Note, despite the fact lower1:/a/[b] is opaque, we need to continue to look
into lower0 because children c has an absolute redirect.

Following is a reproducer.

Watch me make foo disappear:

 $ mkdir lower middle upper work work2 merged
 $ mkdir lower/origin
 $ touch lower/origin/foo
 $ mount -t overlay none merged/ \
         -olowerdir=lower,upperdir=middle,workdir=work2
 $ mkdir merged/pure
 $ mv merged/origin merged/pure/redirect
 $ umount merged
 $ mount -t overlay none merged/ \
         -olowerdir=middle:lower,upperdir=upper,workdir=work
 $ mv merged/pure/redirect merged/redirect

Now you see foo inside a twice redirected merged dir:

 $ ls merged/redirect
 foo
 $ umount merged
 $ mount -t overlay none merged/ \
         -olowerdir=middle:lower,upperdir=upper,workdir=work

After mount cycle you don't see foo inside the same dir:

 $ ls merged/redirect

During middle layer lookup, the opaqueness of middle/pure is left in
the lookup state and then middle/pure/redirect is wrongly treated as
opaque.

Fixes: 02b69b284cd7 ("ovl: lookup redirects")
Cc: <stable@vger.kernel.org> #v4.10
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/namei.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -55,6 +55,15 @@ static int ovl_check_redirect(struct den
 			if (s == next)
 				goto invalid;
 		}
+		/*
+		 * One of the ancestor path elements in an absolute path
+		 * lookup in ovl_lookup_layer() could have been opaque and
+		 * that will stop further lookup in lower layers (d->stop=true)
+		 * But we have found an absolute redirect in decendant path
+		 * element and that should force continue lookup in lower
+		 * layers (reset d->stop).
+		 */
+		d->stop = false;
 	} else {
 		if (strchr(buf, '/') != NULL)
 			goto invalid;
