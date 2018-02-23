Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413702-2-9978622764711124216
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413701; b=CWW9V1vsan/1nCIOBU1V1unKwqXVNOB47whFY1qctV03kv0
    27qscOHu61jx2JlDTBxTpkr5EDXW+pVZISDtaudr8amipkf8WabBrU+/QIk0+RXb
    jsk++vRgz0z1o7JVx+SMJ9dajXCraxPsrQY4kwW8W28QfDZ2ibmxwKQaaGiwCUP/
    Eb3Qo2THjBKvooOA5kzTFn/8QvMacCGCyojWncqa+Scb0DU/HRDR4WiJR92zsihS
    0cJgFTv82w2xGN6XbkAvYhqXG4zffsdxDwJvNFAPcRgjO+4podeb8TU7rW4cvdr/
    QRs5/j+kHUUctt0ZBSee79Dt1rIHPXjVwS3ILcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413701; bh=L95GNYTfeRAmzIcfaAOzrQdSN6
    qNFxEloZIbi/GJ17Q=; b=ej3MzqKMZsdxJS/rbTHnqkJs8QRWtwd7oYKCDHFSL2
    p5QDaln4S6iUf4qhCIdR8SGfKIZXEyQh8KzpCzI8njC9k9sewtLgK+kGgWkhgxv2
    Kz/Vutj3VkO2x6CYGj005O1B9STqFwATkh0qQLaCMqhmLDJV6x1NO9ABhpR1HGOt
    J/eRQfCSTMjO8mOMv3bNulEwkVspowjbaYsAl/U35U/ThRAZFOcPRA0vmIttxj3J
    fCgYkCGvVv24bSP8REYq4N9DAXc60TBUTEweaIZd+btPiq8RlZBUF+Ftqa315es+
    oPNKQ27RVLD2Pic/05Z7xoe+Lr3SuX9sagV1khBHrQBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964830AbeBWSxx (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:53 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47530 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964828AbeBWSxw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:52 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 101/159] scripts/kernel-doc: Dont fail with status != 0 if error encountered with -none
Date: Fri, 23 Feb 2018 19:26:49 +0100
Message-Id: <20180223170755.666412125@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Will Deacon <will.deacon@arm.com>


[ Upstream commit e814bccbafece52a24e152d2395b5d49eef55841 ]

My bisect scripts starting running into build failures when trying to
compile 4.15-rc1 with the builds failing with things like:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:2078: error: Cannot parse struct or union!

The line in question is actually just a #define, but after some digging
it turns out that my scripts pass W=1 and since commit 3a025e1d1c2ea
("Add optional check for bad kernel-doc comments") that results in
kernel-doc running on each source file. The file in question has a
badly formatted comment immediately before the #define:

/**
 * struct brcmf_skbuff_cb reserves first two bytes in sk_buff::cb for
 * bus layer usage.
 */

which causes the regex in dump_struct to fail (lack of braces following
struct declaration) and kernel-doc returns 1, which causes the build
to fail.

Fix the issue by always returning 0 from kernel-doc when invoked with
-none. It successfully generates no documentation, and prints out any
issues.

Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/kernel-doc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -3216,4 +3216,4 @@ if ($verbose && $warnings) {
   print STDERR "$warnings warnings\n";
 }
 
-exit($errors);
+exit($output_mode eq "none" ? 0 : $errors);
