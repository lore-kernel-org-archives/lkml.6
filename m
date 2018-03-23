Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-999974-1521800379-2-14789667222530740449
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
    t=1521800379; b=SkTiswKGpqvhzI3+dOvO81QXOucPsTZTyhVO2OAqGhm/aA2
    r2gEAOT8/fiwuOjPEj6r3u8ww4gEA0RRW5D4ausdD4nYk7Wc+CT9YMhhiPoJPrV/
    tsvlcmYBa3mvh4zdEsIdOFng/xnUYcNPzDgngaFFF46QhlnOUEPViggClXLywiQ5
    2WoIZUmj5FvUzyXBU6rIsAElW5WV3q2eAtQlcPK9eiSGQmDkk3n/k71aOmg1i5wa
    BCRhNlGq6PBwB+pW30j6GXGVs9JAGisppyj3OiCAUF+PaPg1e4tLvfKy0mwTO317
    I4SgSD/IHdOj8uAJuhvdF3ENQaiIhfO2k5Jq69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521800379; bh=L9grGTrcOL0NEi/3zDkOvAjXyc
    GJ5MujKOBdkDd0GLk=; b=EfHcGIG75zGbWCvphQnst6IxGK0CPjKumscOoq8899
    /xDNHe8mjgBLY+EZPbQFFMyXvsh//D2yCjClRO+IMY8hoK/MciT90v/tly0Y01a9
    8O+GAjRfDXc6RCR/jEYrwpAnBbyIjxLC7RxppQ8bBlY/xvvhFNpRKRNbBMD0Wq59
    eJ14y3VtdDApnfwLDxWpOLI1yAsIxLsF33Pb2FsXM263u5dKBEsc+UzH0phqGgAk
    cL/kPDkqJ9F6tYTvd4G8k3YRpKUEmEVbIJ0niQ4jAyuqg5OU8uP5xsR7U8Eg6Q3w
    syfXqDDR7NKA7p3hOM499UE8Wc05Aju82zTZRA7IrIDQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeCWKTe (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:19:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933985AbeCWKTc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:19:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 36/47] cifs: small underflow in cnvrtDosUnixTm()
Date: Fri, 23 Mar 2018 10:55:27 +0100
Message-Id: <20180323094249.662758588@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 564277eceeca01e02b1ef3e141cfb939184601b4 ]

January is month 1.  There is no zero-th month.  If someone passes a
zero month then it means we read from one space before the start of the
total_days_of_prev_months[] array.

We may as well also be strict about days as well.

Fixes: 1bd5bbcb6531 ("[CIFS] Legacy time handling for Win9x and OS/2 part 1")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/netmisc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -980,10 +980,10 @@ struct timespec cnvrtDosUnixTm(__le16 le
 		cifs_dbg(VFS, "illegal hours %d\n", st->Hours);
 	days = sd->Day;
 	month = sd->Month;
-	if ((days > 31) || (month > 12)) {
+	if (days < 1 || days > 31 || month < 1 || month > 12) {
 		cifs_dbg(VFS, "illegal date, month %d day: %d\n", month, days);
-		if (month > 12)
-			month = 12;
+		days = clamp(days, 1, 31);
+		month = clamp(month, 1, 12);
 	}
 	month -= 1;
 	days += total_days_of_prev_months[month];
