Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771A1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AEB02082C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 01:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="R7YB7UDn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yq8K5vFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfBDBf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 20:35:57 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39957 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727364AbfBDBf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 20:35:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E21162054D;
        Sun,  3 Feb 2019 20:35:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Feb 2019 20:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fosNBr64j7N3LqvNeuUMYV4VjDM
        KlvGUlOdVmegIm5Q=; b=R7YB7UDnaaRDdxzEk+14bbqBt3n5F/yn3CvLI/FfAXV
        6BXdo4VvTfs6YBQqxySevS9eEwuGhYSxp2zc2nieAlrLbLHA+ES9cIkQhkiLxFbE
        iZiOZZL0NtkAx0Ed6z2G3aaOWpf43a7HnoLmmlaLID1kLdcgy4JRykCqJ2VM27zO
        poGTeNX+OZ4UVyHpJiXQtk6zs6+tzbFW8sQMAB/gzufETl219RLFGzI3j/xlLRpC
        JmXunhpvHfoCM8cWbWHN3aSHRfVcgFJ8dUS+CKLKXwRgwVw/Ru3MNdrJxwJSDeOM
        rZShDMqRwSQ9cv2CAd+iEu9bq0EJ3pL9Rh7+j5bSJsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fosNBr
        64j7N3LqvNeuUMYV4VjDMKlvGUlOdVmegIm5Q=; b=yq8K5vFq6T9P6ZVVMBw9mb
        0qG4etlLJcgx9e5v1pGYB0dF/0TfBay3rPnA2WGdv9K9LlOAOH/uye6B5VwhR5QC
        DIsrw/YG4n9oFWkoc5KQLaPm80NiaucxuMRQ2nNj1uKlV8I8P5poffQtqWM2TiAu
        TfCSDIG7lq+4w0OWYgWeh6rwaN3nm9Q8V5FLbkeuyuWVRZ4lL7jD8kntbNp2vhl3
        nHCp+drzGmrxUHcEZJebKMdwYwd6zUGSOy85C+6TycYnoRm9oIb3115XMAbja4ZF
        iITAMsyq0xeJ8XlzgZz9sEz4jedtOSwsQF9a1ZcKdXqMVGsH4k1nc4y62VmcVS0Q
        ==
X-ME-Sender: <xms:-JZXXMevt7vPb58i2jCgPwz4QIcjYQXqxATx0QWcMpq0Yh3mOep_vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrkeefgdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlfedtmd
    enucfjughrpeffhffvuffkfhggtggujgfofgesthdtredtofervdenucfhrhhomhepfdfv
    ohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtohgsihhnrdgttgeqnecuffhomh
    grihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvuddrgeegrddvvdejrdduheejnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrh
    fuihiivgeptd
X-ME-Proxy: <xmx:-ZZXXCTlSuswCPlYyy8yuJzPwEbwNAbHyl8cTorh29bGuGJcnw0xxA>
    <xmx:-ZZXXOrNOmQxpt7b0XxF-fI_M8EEvIE4MQdg1qGqg4YB938Rh0lb1Q>
    <xmx:-ZZXXLVGqmIrZmaCyCUMQxP2RTEiptO5OalMGG5IpPTEGt-gOX7LUg>
    <xmx:-5ZXXILPRVR2SAoJQQa6cPS6Gzg4ynxIJBMJFGTQ8zRk6luq9ILQHQ>
Received: from localhost (ppp121-44-227-157.bras2.syd2.internode.on.net [121.44.227.157])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8F69FE43B7;
        Sun,  3 Feb 2019 20:35:51 -0500 (EST)
Date:   Mon, 4 Feb 2019 12:35:44 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: Increase width of first /proc/slabinfo column
Message-ID: <20190204013544.GA9555@eros.localdomain>
References: <20190201004242.7659-1-tobin@kernel.org>
 <20190201024310.GC26359@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201024310.GC26359@bombadil.infradead.org>
X-Mailer: Mutt 1.11.2 (2019-01-07)
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 06:43:10PM -0800, Matthew Wilcox wrote:
> On Fri, Feb 01, 2019 at 11:42:42AM +1100, Tobin C. Harding wrote:
> > Currently when displaying /proc/slabinfo if any cache names are too long
> > then the output columns are not aligned.  We could do something fancy to
> > get the maximum length of any cache name in the system or we could just
> > increase the hardcoded width.  Currently it is 17 characters.  Monitors
> > are wide these days so lets just increase it to 30 characters.
> 
> I had a proposal some time ago to turn the slab name from being kmalloced
> to being an inline 16 bytes (with some fun hacks for cgroups).  I think
> that's a better approach than permitting such long names.  For example,
> ext4_allocation_context could be shortened to ext4_alloc_ctx without
> losing any expressivity.
> 
> Let me know if you can't find that and I'll try to dig it up.

Hi Willy,

I haven't managed to find the patch, I grep'ed LKML using a bunch of
search terms via the google group linux.kernel.  Then I tried a bunch of
different search strings in google prefixed with `site:kernel.org`.  All
to no avail.

I have an idea how to fix it without making life less convenient for
developers *or* for users, I know we don't discuss changes without a
patch so I'll hack it up.

I'm sure your solution contains things I don't understand yet (read: the
cgroups bit) so I'd love to bring your patch back to life but am happy
to work on another solution as well in the name of education.


thanks,
Tobin.
