Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AB8JxZrBZS2PSHphpH2neLexKsk94yEQbYa5pxYcnzmwV0O22Ml8YY4y2zPArDKRcBidAFop3ifL
ARC-Seal: i=1; a=rsa-sha256; t=1524579271; cv=none;
        d=google.com; s=arc-20160816;
        b=G+yx1HfKwynNh5xmBcHkMSCpWDKfOP4ruqBtWMm5J+yJYu3P5XPGKuMTEoMvIlNcaA
         5xhrevqU0gk54Kw2rZHqOEH7jT21KkKkC6b3bC9A6OCx/U4e2TwU+LPjP++raU855mjl
         R5JbhizJ8OhGmZAVTgRCb1INUVhRP8Km0y2BQfp+w2Af7wej7XPMotADzf5t/Hng8wyg
         El5nm2kuavCtgyOndu3ItkzFOxYB+3CvLLutANbuQ3AeoL9no8E6a/rmVv1NXl/KfIw+
         U8CaSzOA0l+SMmIY6raHiQi9FZcs7c8Ia2SNFGuGNijE/yxOBYlINszS0Xxnifr5r1Ig
         8mUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Zl2mskBXWwWzQahAlS4sV9xFnlfaFrDF6BqYR0hCTN8=;
        b=UUeaTwpHBLGrGc1NX90nsK7cIv1ZUHVGI4VgwTUr7OqT/diTlINdBYy34YGj27eaCJ
         pVAL9aG5YD3X2WUrIXhRLgCREL8P/E1ayvU/nP3E0ZqAJVc46iq7H751lC7EIcZsBMwL
         QoOm8dK+XFzd+uELoTkOW0ILuKCxVnJnlYpllDdIkcu7qtgYgqcz3FSqb5HtaCh/W4Bq
         z6HHJ73m7nwJ1Mq4ny46Rg0muUaO323pybNjtWdM7VpHbf64LveY74PoVKpT5SaCUlGN
         9dPQMxUMZ0z7HmMQd3rQ+yJOed/QpSQdlS6/h5yqEZPjYgP465RgcSDXzfmFN64QFyGz
         GwEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Tue, 24 Apr 2018 16:16:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Corey Minyard <minyard@acm.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org, drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/39] ipmi: simplify procfs code
Message-ID: <20180424141601.GC26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419124140.9309-17-hch@lst.de> <f322f243-9ab1-7e9f-00a4-9652cd288ca2@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f322f243-9ab1-7e9f-00a4-9652cd288ca2@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178472540775921?=
X-GMAIL-MSGID: =?utf-8?q?1598637233854663027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 10:29:29AM -0500, Corey Minyard wrote:
> On 04/19/2018 07:41 AM, Christoph Hellwig wrote:
>> Use remove_proc_subtree to remove the whole subtree on cleanup instead
>> of a hand rolled list of proc entries, unwind the registration loop into
>> individual calls.  Switch to use proc_create_single to further simplify
>> the code.
>
> I'm yanking all the proc code out of the IPMI driver in 3.18.  So this is 
> probably
> not necessary.

Ok, I'll drop this patch.
