Return-Path: <bhe@redhat.com>
X-Google-Smtp-Source: AB8JxZog9E3niD3d1kggVEixm5SRBKW0Ua57hbhF4T6l93xWVpo+ryDYInjCHO1nXTmp2L2me5JK
ARC-Seal: i=1; a=rsa-sha256; t=1525781489; cv=none;
        d=google.com; s=arc-20160816;
        b=YFZoVD3mYapquvXvsLFFICpHXLculLAPf8Uc+MsX/e3Y+MUdo3jxJ0Lb6dsR9A7Qf3
         Qimpirzv/Qb3lh3vU3GbtBpbaSCNlov270rmYHyFXxr8WjNSWCbQqiu0OHZGdmRTnRXH
         c4r5vClu6ZmPia19jay9+kvS2ZjiiEBnxvQdaoZIMAq+W9BqkPF+v6h0vMkxCvxmmeBF
         gL0JF19B1esct9dE0ywJ/3J9Fb2Zl+4njtd+/tXMt3kONq587h7gtwpRuXAEm8YTRWtS
         MrorHK0eUoFW8Sazl9HjqmbaJGLI++npE044dOov6ms/MhN/d01DM841gPpLJZ7VXi1F
         G7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=HLe2FVVAIerf7nxqbA7s0XW/zDsrJCf5LkNQ1GS3jSo=;
        b=HT6Cz2tpq/JEnadIYODPZafTFNw+s681ssP6Rgtmbu84cGIlcQWKaV1qXZsU5QcYix
         6Yzd70+kb722bJdZebKARNtyNpbV+hQ/rqQq5c0xJ+JGXqLYgmdZL3B6bdz60W+olRah
         /qgnFxxfkln8kdwjAem+RZQ0omWtvqWNzC0YwGs7a05za6GGo07hCXmpzXqPaZggOS3U
         aj/I1/IqNyu2w95hDXBOMioMYTv0lJhcKyu2VUFYGSruVXNfUrohZSi8ZBpXwVu9LD7p
         7Qux4Y8Y6AmpE7C47AQRTuz7pXw5cjRCpWvwNF3YxkWPZ8o+wVoo629+3s3vUwRNOjpB
         v/dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bhe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=bhe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bhe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=bhe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Tue, 8 May 2018 20:11:23 +0800
From: Baoquan He <bhe@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	robh+dt@kernel.org, dan.j.williams@intel.com,
	nicolas.pitre@linaro.org, josh@joshtriplett.org,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	David Airlie <airlied@linux.ie>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Stephen Hemminger <sthemmin@microsoft.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Keith Busch <keith.busch@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Brijesh Singh <brijesh.singh@amd.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Borislav Petkov <bp@suse.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
	devel@linuxdriverproject.org, linux-input@vger.kernel.org,
	linux-nvdimm@lists.01.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180508121123.GI30581@MiWiFi-R3L-srv>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
 <20180426011837.GA79340@WeideMacBook-Pro.local>
 <20180507011429.GG30581@MiWiFi-R3L-srv>
 <20180508114845.GA19459@WeideMacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508114845.GA19459@WeideMacBook-Pro.local>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598131700389744779?=
X-GMAIL-MSGID: =?utf-8?q?1599897850269952055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/18 at 08:48pm, Wei Yang wrote:
> On Mon, May 07, 2018 at 09:14:29AM +0800, Baoquan He wrote:
> >Hi Wei Yang,
> >
> >On 04/26/18 at 09:18am, Wei Yang wrote:
> >> On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
> >> >The struct resource uses singly linked list to link siblings. It's not
> >> >easy to do reverse iteration on sibling list. So replace it with list_head.
> >> >
> >> 
> >> Hi, Baoquan
> >> 
> >> Besides changing the data structure, I have another proposal to do the reverse
> >> iteration. Which means it would not affect other users, if you just want a
> >> reverse iteration.
> >> 
> >> BTW, I don't think Andrew suggest to use linked-list directly. What he wants
> >> is a better solution to your first proposal in
> >> https://patchwork.kernel.org/patch/10300819/.
> >> 
> >> Below is my proposal of resource reverse iteration without changing current
> >> design.
> >
> >I got your mail and read it, then interrupted by other thing and forgot
> >replying, sorry.
> >
> >I am fine with your code change. As I said before, I have tried to change
> >code per reviewers' comment, then let reviewers decide which way is
> >better. Please feel free to post formal patches and joining discussion
> >about this issue.
> 
> Yep, while I don't have a real requirement to add the reverse version, so what
> is the proper way to send a patch?
> 
> A patch reply to this thread is ok?

I am not sure either. Since my patches are still under reviewing. And
you have pasted your patch. It depends on maintainers, mainly Andrew and
other reviewers who have concerns.
