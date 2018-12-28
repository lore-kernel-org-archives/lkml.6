Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD65C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3E0218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 08:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="VLrOv9e2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xSM5AZ/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeL1I2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 03:28:02 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44633 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbeL1I2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 03:28:01 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CD16220F50;
        Fri, 28 Dec 2018 03:27:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 28 Dec 2018 03:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=9q1g4z5sx2eHF0qHK+Z79m7hinj
        qkKoj2v/YbAix3qs=; b=VLrOv9e29ZM4WxBdbQBh+GpivgChbUWo2fqRVX9FLHZ
        hGWnmoVdRc9PpWE3tdjRho3I+n6xCSswkfoT/ByPOmJicxTBeQxIInTwXAJC0Usi
        17mph+3IYOCt3eGMHO7/9BN+qJ7g5Fi1rq+dxTvFt1VNmRZjKoBeYPAzCyMHf1Bb
        vWvH8Pdnvo7+mvBroA4Dcx0hbwcPWjNkoi6/n4iM+FIP7fgUrxEtgiAp/F8l+xp2
        oupqU2lPM1KE0Nh7MYOltZh0Cze0awylpdJjCG9TOd5F6nEqTjXrFSFJbAM1O3N9
        niD6DG5ZANOLpb1ngipzs4UUqvahLbiXlTQ5HODgPUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=9q1g4z
        5sx2eHF0qHK+Z79m7hinjqkKoj2v/YbAix3qs=; b=xSM5AZ/wX+1Yzz1QpmF/ER
        1iVY9jxOImS4eKz14JP2FaxPMbVvT2edutShBw+FFMmjPbJ/mFBNwoTMFvIGA2Zz
        jIbWPXcvwJ7BmKZCFCYL55BAvqHI8oqUu0IeOAqGftw+v/Ch5Nj8f/XhP1vCSVP7
        zjOH6KVisBxKTzeZiO//hsrSqynQHr1HCR8VeqqigeviHFa5yp8+XO/GrynMIAgS
        ojSgkWO1+jnT+HelNK5ZjrvJIw1Q2ZBw9Q8LUMvt0JsauCzhGbNXCEWH2QlWlTAO
        Taj4P5GDhE2Zn7w+pTlc1uUq9ei5ziD7GH1Ji74lYmHCoH1275hx5Z0MEFrK+riA
        ==
X-ME-Sender: <xms:h94lXD3qYmtV2z6kd8DUtNyL1ldY80JCBYgJWOIJbhvKyK97UK-AVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrtdeggdduvddtucdltddurdegtdekrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrd
    dutdejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:h94lXG4ugKBpLfoUyoZXirdahW5OVckN_ccPyoATQANbXMPaEC54TA>
    <xmx:h94lXF7qmjDEmxF_u_t2YMtZI8FqoD3DRdwIWQuf6VBF8aEIwhNDIA>
    <xmx:h94lXB4nKyaSVGY0Yl0PWA95QOC8l71gOzYxnEjR6ONBOVgo8gLOWA>
    <xmx:jd4lXMi6LcVouo5Iqwa5CeNSGKxMT4-pObhhpPy0kXj9g4cMT3ns7A>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 16E0310085;
        Fri, 28 Dec 2018 03:27:51 -0500 (EST)
Date:   Fri, 28 Dec 2018 09:27:49 +0100
From:   Greg KH <greg@kroah.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Daniel Wang <wonderfly@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        Alexander.Levin@microsoft.com,
        Andrew Morton <akpm@linux-foundation.org>,
        byungchul.park@lge.com, dave.hansen@intel.com, hannes@cmpxchg.org,
        jack@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mel Gorman <mgorman@suse.de>, mhocko@kernel.org, pavel@ucw.cz,
        penguin-kernel@i-love.sakura.ne.jp,
        Peter Zijlstra <peterz@infradead.org>, tj@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>, vbabka@suse.cz,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: 4.14 backport request for dbdda842fe96f: "printk: Add console
 owner and waiter logic to load balance console writes"
Message-ID: <20181228082749.GA28315@kroah.com>
References: <20181022100952.GA1147@jagdpanzerIV>
 <CAJmjG2-c4e_1999n0OV5B9ABG9rF6n=myThjgX+Ms1R-vc3z+A@mail.gmail.com>
 <20181109064740.GE599@jagdpanzerIV>
 <CAJmjG28Q8pEpr67LC+Un8m+Qii58FTd1esp6Zc47TnMsw50QEw@mail.gmail.com>
 <20181212052126.GF431@jagdpanzerIV>
 <CAJmjG29a7Fax5ZW5Q+W+-1xPEXVUqdrMYwoUpSwL1Msiso6gtw@mail.gmail.com>
 <20181212062841.GI431@jagdpanzerIV>
 <20181212064841.GB2746@sasha-vm>
 <20181212081034.GA32687@jagdpanzerIV>
 <20181228001651.GA514@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181228001651.GA514@jagdpanzerIV>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 09:16:51AM +0900, Sergey Senozhatsky wrote:
> On (12/12/18 17:10), Sergey Senozhatsky wrote:
> > And there will be another -stable backport request in a week or so.
> 
> The remaining one:
> 
> commit c7c3f05e341a9a2bd

Now queued up, thanks.

greg k-h
