Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6AEC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779CE204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779CE204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbeJSCN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:13:28 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33135 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbeJSCN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:13:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 78-v6so12871470pfq.0;
        Thu, 18 Oct 2018 11:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtsuFY68noC82iGIxEwSUQqR1ROxAQYMV8c73mkur/M=;
        b=B5IdxdOISH44cGrFtJTU/gfwJ+HGJEPeNrhep9M5V7Jza1zYDwYGLCs+qwi7iAYqW+
         rMqTI6bwtPIcrAO+4w8YsJJSSCzKKJBaquR5gMx6LFNoCiNvN56rIpIe0jSHArSmsfGg
         eXu8OOga9lO/g3lzxVcur/khzbBUr7nQ725300FKgLgCfiIA74vgAY7q7K4rVVwDBF2Q
         4UNIuoSymkVN2r5ezjn0JDFjVOZisxkcD+DBZg5iYvVwBbI9OSYXzmrZhDXT2/6XWDTV
         ZxJ05LxTHt/KVqW5zaUDgoeRUFzAikg3NJobB4L6XlELJ9w2PQM6ziSh+BJq4W7T6kwL
         r01A==
X-Gm-Message-State: ABuFfojJWUj+G7sQ6PKSC2X4nwBplbPofjkdC7WeGJOI3QE/MTTNPZBg
        KOqR1Cr6s8XPm7fD9a/IGnE=
X-Google-Smtp-Source: ACcGV63rVlD3VHgHIsnIZPTYyVkWs2UqXEGLfLMqIXWrhfeVXJuahg9E9npS7eebkCqPANpWJG4MWw==
X-Received: by 2002:a63:ee13:: with SMTP id e19-v6mr28540447pgi.8.1539886277341;
        Thu, 18 Oct 2018 11:11:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h88-v6sm47855786pfa.184.2018.10.18.11.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:11:16 -0700 (PDT)
Message-ID: <1539886275.81977.17.camel@acm.org>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        tj@kernel.org, akpm@linux-foundation.org
Date:   Thu, 18 Oct 2018 11:11:15 -0700
In-Reply-To: <20181015150926.29520.45280.stgit@localhost.localdomain>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
         <20181015150926.29520.45280.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 08:09 -0700, Alexander Duyck wrote:
+AD4 +-static void +AF8AXw-driver+AF8-attach+AF8-async+AF8-helper(void +ACoAXw-dev, async+AF8-cookie+AF8-t cookie)
+AD4 +-+AHs
+AD4 +-	struct device +ACo-dev +AD0 +AF8-dev+ADs
+AD4 +-
+AD4 +-	+AF8AXw-device+AF8-driver+AF8-lock(dev, dev-+AD4-parent)+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo If someone attempted to bind a driver either successfully or
+AD4 +-	 +ACo unsuccessfully before we got here we should just skip the driver
+AD4 +-	 +ACo probe call.
+AD4 +-	 +ACo-/
+AD4 +-	if (+ACE-dev-+AD4-driver) +AHs
+AD4 +-		struct device+AF8-driver +ACo-drv +AD0 dev+AF8-get+AF8-drvdata(dev)+ADs
+AD4 +-
+AD4 +-		if (drv)
+AD4 +-			driver+AF8-probe+AF8-device(drv, dev)+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4 +-	+AF8AXw-device+AF8-driver+AF8-unlock(dev, dev-+AD4-parent)+ADs
+AD4 +-
+AD4 +-	put+AF8-device(dev)+ADs
+AD4 +-
+AD4 +-	dev+AF8-dbg(dev, +ACI-async probe completed+AFw-n+ACI)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4  static int +AF8AXw-driver+AF8-attach(struct device +ACo-dev, void +ACo-data)
+AD4  +AHs
+AD4  	struct device+AF8-driver +ACo-drv +AD0 data+ADs
+AD4 +AEAAQA -945,6 +-971,25 +AEAAQA static int +AF8AXw-driver+AF8-attach(struct device +ACo-dev, void +ACo-data)
+AD4  		return ret+ADs
+AD4  	+AH0 /+ACo ret +AD4 0 means positive match +ACo-/
+AD4  
+AD4 +-	if (driver+AF8-allows+AF8-async+AF8-probing(drv)) +AHs
+AD4 +-		/+ACo
+AD4 +-		 +ACo Instead of probing the device synchronously we will
+AD4 +-		 +ACo probe it asynchronously to allow for more parallelism.
+AD4 +-		 +ACo
+AD4 +-		 +ACo We only take the device lock here in order to guarantee
+AD4 +-		 +ACo that the dev-+AD4-driver and driver+AF8-data fields are protected
+AD4 +-		 +ACo-/
+AD4 +-		dev+AF8-dbg(dev, +ACI-scheduling asynchronous probe+AFw-n+ACI)+ADs
+AD4 +-		device+AF8-lock(dev)+ADs
+AD4 +-		if (+ACE-dev-+AD4-driver) +AHs
+AD4 +-			get+AF8-device(dev)+ADs
+AD4 +-			dev+AF8-set+AF8-drvdata(dev, drv)+ADs
+AD4 +-			async+AF8-schedule(+AF8AXw-driver+AF8-attach+AF8-async+AF8-helper, dev)+ADs
+AD4 +-		+AH0
+AD4 +-		device+AF8-unlock(dev)+ADs
+AD4 +-		return 0+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4  	device+AF8-driver+AF8-attach(drv, dev)+ADs

What prevents that the driver pointer becomes invalid after async+AF8-schedule() has
been called and before +AF8AXw-driver+AF8-attach+AF8-async+AF8-helper() is called? I think we need
protection against concurrent driver+AF8-unregister() and +AF8AXw-driver+AF8-attach+AF8-async+AF8-helper()
calls. I'm not sure whether that is possible without introducing a new mutex.

Thanks,

Bart.

