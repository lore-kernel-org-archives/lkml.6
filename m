Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3437CC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0444920874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OcFFMzXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVItNS6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfAJTRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:17:01 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:56647 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728748AbfAJTRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:17:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0906014B0D;
        Thu, 10 Jan 2019 14:16:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 10 Jan 2019 14:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6qeHQhqiowfV1AXW8PA8kiNqumV
        6PSgdPFAxIL2Fw6Q=; b=OcFFMzXy9SL6EhTXjFM1JKCtWHZQQCol3SW2uG/UzQB
        PvvsmC1JZhRXZXwMn+oJTBJdjpRaloCBadgpQ+yTaYSVFZPh6x5+q5569a0zIsHj
        vigKG/74LRoGpsnwhtM7iKmAZfR/7gD6zTLuh6r0L2eZ3lck7l1RD7NDaj9h0y/i
        m2qdSREkb5f4SIJQkgzTmY+xpS+IjpewhZI8kp8S7l+ndJ+FLwxrOihWo6OaFz/m
        sI11t7c6Is4skIkZib9gY5/Egx1uP16YzfwahCu6zAlYqAE3cUqIgUVC5dEySjJm
        YGAkbHHa4dkqNX/qzScwtKKuOBTT9yHHZc+Ahyg7nMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6qeHQh
        qiowfV1AXW8PA8kiNqumV6PSgdPFAxIL2Fw6Q=; b=XVItNS6LMERFhsdCY7mnRU
        RLIMTg2W6mfOEqitCRv6VRaHutliQ1GviCo6ptEYsU+8qvJkqGAz61JiX/45pexI
        +wAzioHs/uavD5ISrAbiWWTxsy1YZ8lOgD5BgoKfXpQ5AKC/ezdW8rwWUZYgjr+7
        69AJlax8sOx1osnOPcXZE0vOusQpv9xPOq/orpiN2gM8SnkvWMAr9gb7qbDXsWTG
        A9mGxjJnPP4r6NWBwb0kw3N9DabtXqc8XCabL+7G1hlGXsHXFtE6aYdWGFIIAAq6
        yZUGGxhyrTSr61IMqSxs5lGNsryM/8M4ZoDEGiqkd411IlZR4OBN7Q2r4ZuU9WYg
        ==
X-ME-Sender: <xms:KJo3XFFqdLJBuxPuopi-OXtfWGJxar_rKw7G_M-mUknlyStvn1dEqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrfeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuphgrmhfkphculdeftd
    dtmdenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefi
    rhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrke
    elrddutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:KJo3XPkTweLvrQZ5s01_YIOUe7GIZoYdVbEj3ylHuChU4vo1qM-X6g>
    <xmx:KJo3XI3WRjTXiAzDt3uLahGQS4_OWPWiMqCYpuK12-YnWppTYICNpw>
    <xmx:KJo3XDT-MCvj00CQnSHrov34AaKEdrN72gIh-nh062h2uaECGzlu0w>
    <xmx:Kpo3XFqdAv3bQx0mqYzuJooZxgLlJrfzHb87oFLEEpyp0aP25Div3A>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id E60A8102A0;
        Thu, 10 Jan 2019 14:16:54 -0500 (EST)
Date:   Thu, 10 Jan 2019 20:16:53 +0100
From:   Greg KH <greg@kroah.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: Re: [PATCH 2/2] x86/selftests/pkeys: fork() to check for state being
 preserved
Message-ID: <20190110191653.GF18221@kroah.com>
References: <20190102215657.585704B7@viggo.jf.intel.com>
 <20190103135225.4929F217D9@mail.kernel.org>
 <0c10a3c9-67a7-c404-da0f-d9df079fdd23@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c10a3c9-67a7-c404-da0f-d9df079fdd23@intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 10:57:24AM -0800, Dave Hansen wrote:
> On 1/3/19 5:52 AM, Sasha Levin wrote:
> > This commit has been processed because it contains a -stable tag.
> > The stable tag indicates that it's relevant for the following trees: all
> > 
> > The bot has tested the following trees: v4.20.0, v4.19.13, v4.14.91, v4.9.148, v4.4.169, v3.18.131, 
> > 
> > v4.20.0: Build OK!
> > v4.19.13: Build OK!
> > v4.14.91: Build OK!
> > v4.9.148: Failed to apply! Possible dependencies:
> >     f50b4878329a ("x86/pkeys/selftests: Fix pkey exhaustion test off-by-one")
> 
> Protection keys was merged in 4.8.  We can ignore any of the selftests
> changes before that.
> 
> But, it looks like the 4.9 selftests are a bit behind mainline.
> Probably because I didn't cc stable@ on f50b4878329a.  I don't have a
> strong opinion as to how up-to-date we want to keep the -stable
> selftests.  Shua, is there a usual way that folks do this?

I wouldn't worry too much about selftests.  Usually people run the
latest selftests (like 4.20) on older stable kernels, as they "should"
just work properly (or at least fail gracefully).

thanks,

greg k-h
