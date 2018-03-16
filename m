Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214772-2-10588821781710505203
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214771; b=s57LyL+G4p4X4bnpfQ4LfJSRB4fyp+XiFdb0dYHqp+Ic8oQ
    qe0P2Xwm1jJFHOtd3VqQAmN3sIiAh/aBJwc6SMFJ0gW1e2593gnbSP7N0Er1g9im
    os5gQgKIUn0nrTqh4ZCLsIKdQ9z5lJyWD0hnIaU5DISmr1SPfy5VJZSbUil2GDG4
    FGzhvPp24fLNcqhWAvM12UntpqcPl0omOn/d+m1kKVRCRJaJ5y+BZgEv0uiHK/5T
    iqxNGMt9YqMz42h32POqKsNz0j4zKOpKNzzxnVQagUTIJmv/98kEabRqRP1hbBfU
    yrlYWUPBljOMiUxN2Boj1vvyUW4y2jgQSsgUmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214771; bh=vaqw5UURa9hyr03f3g0V1jPvGe
    KOzS7WXhgKULBstIk=; b=Xz35l960ZV+8/qIAQzmf234CdGqP1c7mUhHCZY4vUg
    rQUFgpC9HBDPZnlMcAsYVSXR6Z+t3ObUPTaUJKMCuzY0O7jiAfgloJ09vtZjBZC+
    vlGnqNY5prKq3n4GiXLKJuhqkXWNzzxwLssJjHf0r1DgEj7mS0Qe7HOa29EzobpD
    gdOQyLkQkBtjGAwJXW8BkY3O7cOS17F96j1ND9V5gnXT8d04txzbnSlfIwuOspFz
    sjYRd/CUdrU+MVhxc9VLGTWuAAFRCoudWXxYmHm57GspHOOXWggUcc8+zp0o92dq
    gEZha93qIKLYvEUPCUVbbCJbjMsMbe/4nNf4fquAFOmQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754628AbeCPPj2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:39:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754613AbeCPPj0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:39:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Mori Hess <fmh6jj@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 4.15 012/128] staging: comedi: fix comedi_nsamples_left.
Date: Fri, 16 Mar 2018 16:22:33 +0100
Message-Id: <20180316152336.881831240@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: Frank Mori Hess <fmh6jj@gmail.com>

commit a42ae5905140c324362fe5036ae1dbb16e4d359c upstream.

A rounding error was causing comedi_nsamples_left to
return the wrong value when nsamples was not a multiple
of the scan length.

Cc: <stable@vger.kernel.org> # v4.4+
Signed-off-by: Frank Mori Hess <fmh6jj@gmail.com>
Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/comedi/drivers.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/staging/comedi/drivers.c
+++ b/drivers/staging/comedi/drivers.c
@@ -484,8 +484,7 @@ unsigned int comedi_nsamples_left(struct
 	struct comedi_cmd *cmd = &async->cmd;
 
 	if (cmd->stop_src == TRIG_COUNT) {
-		unsigned int nscans = nsamples / cmd->scan_end_arg;
-		unsigned int scans_left = __comedi_nscans_left(s, nscans);
+		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
 		unsigned int scan_pos =
 		    comedi_bytes_to_samples(s, async->scan_progress);
 		unsigned long long samples_left = 0;
