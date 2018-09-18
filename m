Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD479ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AF12146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZTSYh8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AF12146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbeIROjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:39:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33413 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeIROjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:39:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id b97-v6so696698plb.0;
        Tue, 18 Sep 2018 02:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2jEOzF87Ru52EyxyRjGnfagIOT+pdY0ttzfdlRdRZM8=;
        b=iZTSYh8PSMkvh2o4lRv96P8yganz98hlvBEyCCSWZ+le8FaCxW8IBOX2TiT+cClw1W
         vLaai41JMGIkaSzSLs68wqavfwWmLD9Jcz0Xen/45qiWtfjq4RqliELqGia51asmfNYI
         3pCSKLQZ8rx4JEkESMHc4ut7eUt17q5ltqCXucOBcirZQojwBo4amcxrZ8IS92q2EzT+
         wn0KEKweBEqRZfberQ1SuKRrHGn/YUH/crrhN7lkT6xdmU07ZWNPFovf0PkNjTME17S0
         HW/z9aovkzxabJ5ssXwKuFWJkyJ95lR6ovqZ3XUbZR+eE04OlDToslu9erXsUnE1bX0c
         cXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2jEOzF87Ru52EyxyRjGnfagIOT+pdY0ttzfdlRdRZM8=;
        b=FpVqP8cpfUev7tEMShEY8EOdg6aKJRJZ8TaefeSE7DvEUQDMsbSgSnNecuc3r09Pqn
         Q8YbO/yBNtksDh9y4Fdqnx3xCDsMDLdKkhaKOQH8KHfTMHJyHypph9kjaD6VxBgQEOyb
         T0pBPMtKEl4iOPj+4HQ54cH5Oih5pN9aAOao0rektEIQXkhpd/J6sYJ/flM62qUh6GrK
         Zsl6SnM89a0MwOuLTNyp3foy07KM2yFq4N/0LQs+1a2BYINT6cN9lkkLmiSQb5xVnNYT
         vNuD0iynUkpEA6anKTKvBdZkDgBmN0IJv0ZRHmus6LHtdwX2slaiHEuSA1Knn3ipDr1v
         IzEg==
X-Gm-Message-State: APzg51A3YuRYVn3GcuOytPokNrql5PkEKysqscGBQVhQgi8oX24jMfq5
        KPHwHlHkn7KpoK73fOsH/Rs=
X-Google-Smtp-Source: ANB0VdawJo1IV9c4ALx2EMdygLZJPJt+WJrIVyntOYX1tF7ShcZ46hHf4a7RKfj3sR9BXWZ9b7jOsA==
X-Received: by 2002:a17:902:710c:: with SMTP id a12-v6mr28907239pll.310.1537261647852;
        Tue, 18 Sep 2018 02:07:27 -0700 (PDT)
Received: from localhost ([110.70.59.176])
        by smtp.gmail.com with ESMTPSA id y64-v6sm18979403pgd.65.2018.09.18.02.07.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 02:07:26 -0700 (PDT)
Date:   Tue, 18 Sep 2018 18:07:22 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 14/33] vfs: Implement a filesystem superblock
 creation/configuration context [ver #11]
Message-ID: <20180918090722.GA463@jagdpanzerIV>
References: <20180911220743.GA13208@roeck-us.net>
 <20180911174641.GA15149@roeck-us.net>
 <153313703562.13253.5766498657900728120.stgit@warthog.procyon.org.uk>
 <153313714181.13253.304098108512966976.stgit@warthog.procyon.org.uk>
 <27113.1536702746@warthog.procyon.org.uk>
 <32382.1536707855@warthog.procyon.org.uk>
 <20180911235403.GA10107@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911235403.GA10107@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (09/11/18 16:54), Guenter Roeck wrote:
> On Wed, Sep 12, 2018 at 12:17:35AM +0100, David Howells wrote:
> > Guenter Roeck <linux@roeck-us.net> wrote:
> > 
> > > [    8.507672] RIP: 0010:reconfigure_super+0x47/0x210
> > 
> > Can you tell me the file and line this corresponds to?
> > 
> I don't know, but some debugging shows that fc->ops == NULL.

This NULL derefs linux-next.

Emergency (sysrq remount/reboot):

emergency_remount()
 do_emergency_remount()
  do_emergency_remount_callback()
   reconfigure_super()

At fc->ops dereference:

 981         if (fc->ops->reconfigure) {
		^^^^^^^^^
 982                 retval = fc->ops->reconfigure(fc);
 983                 if (retval == 0) {
 984                         security_sb_reconfigure(fc);


So the check either better be

	if (fc->ops && fc->ops->reconfigure)

Or, we need to set ->ops properly. But I'm not sure if invoking
->init_fs_context() from emergency-reboot path is going to work
well all the time.

---

 fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/super.c b/fs/super.c
index efb0567c8389..e2e03c47c817 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1017,6 +1017,7 @@ int reconfigure_super(struct fs_context *fc)
 static void do_emergency_remount_callback(struct super_block *sb)
 {
 	struct fs_context fc = {
+		.ops		= &legacy_fs_context_ops,
 		.purpose	= FS_CONTEXT_FOR_EMERGENCY_RO,
 		.fs_type	= sb->s_type,
 		.root		= sb->s_root,

---

	-ss
