Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519838605-2-15813458791049854422
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838605; b=wjf+M86WuLDsnb/jGzPtw5QWMBQf+CVRpA9DF9m/pLVmHGf
    fcURlK0YS9KDMNA4sOtACrbWPgofaA+L7G+RaT3Rq3LC8fOmbBLMblSKf/engMCn
    ARB3J3EHEtRPEwooLYYCfwfrzVDHk9IAGzZlgNxaHD1hodI6Xi2bb7T6hlTlahfI
    63lhUHmLomi+HmXBRXIRdnIMlEjxc4u1VFoWo4o3C1J0l9/ZFgGL4ADkmjoIreVx
    /QrqTtqvcgavmA5Wii+PecKmN4RXNYvWlGRsJMgUYOSouaMyvDKyXtLp/UZGLFrC
    TM3UmdwrOK+UnM8RhTFLYzlfVkG3wPALLgOvBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838605; bh=ONpqKhySjBQBGwSy+wa
    jWL1ei3SWLFO4xFGNRO0QXE4=; b=s7hrp6xjm0rZKOfuNz6fa1THhRjio16XHxe
    xYncCtyWhM71VVnZU5T3TtmJVaFPGoMYnYVHtYE665ppIm/wK2k70YEjdkZq+1WJ
    LJatPjuS50HOOBd51nJSQzc/PVYFEdgRHbv2+4iqUqE6PUDS1u/cVi4dWXeFzk/g
    AW/rHXJm7kzd3IRTqs2WuQIMY0gBB/F8paIQIcPfFmOIDqv3qtESrrDc+mh9+CZ8
    QeSmnjZ8j9KvRvLsPMLQ7rDlMR6LTPkKLrutVY+0YRiRE7cj8yAJtgjoo8W1+fM9
    khSvMr4V00AuoLXt3/32168n4bXXefdOBCETuGzd5U7iZBDozxA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752853AbeB1RWG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:22:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33339 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932630AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@redhat.com>,
        "Marc Dionne" <marc.dionne@auristor.com>,
        "David Howells" <dhowells@redhat.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.418032376@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 074/140] fscache: Fix the default for fscache_maybe_release_page()
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit 98801506552593c9b8ac11021b0cdad12cab4f6b upstream.

Fix the default for fscache_maybe_release_page() for when the cookie isn't
valid or the page isn't cached.  It mustn't return false as that indicates
the page cannot yet be freed.

The problem with the default is that if, say, there's no cache, but a
network filesystem's pages are using up almost all the available memory, a
system can OOM because the filesystem ->releasepage() op will not allow
them to be released as fscache_maybe_release_page() incorrectly prevents
it.

This can be tested by writing a sequence of 512MiB files to an AFS mount.
It does not affect NFS or CIFS because both of those wrap the call in a
check of PG_fscache and it shouldn't bother Ceph as that only has
PG_private set whilst writeback is in progress.  This might be an issue for
9P, however.

Note that the pages aren't entirely stuck.  Removing a file or unmounting
will clear things because that uses ->invalidatepage() instead.

Fixes: 201a15428bd5 ("FS-Cache: Handle pages pending storage that get evicted under OOM conditions")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/fscache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -642,7 +642,7 @@ bool fscache_maybe_release_page(struct f
 {
 	if (fscache_cookie_valid(cookie) && PageFsCache(page))
 		return __fscache_maybe_release_page(cookie, page, gfp);
-	return false;
+	return true;
 }
 
 /**
