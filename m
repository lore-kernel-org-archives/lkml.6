Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3804898-1524163456-2-4632170608888081782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524163455; b=gyfOdWS055nSgH30Hp1JNEk2WWCJspnx3xfl4mZhnMElid5376
    pafZ8Omyg9Trvob0LYWCsi2QO5+lKZdW9+FAcoOf44gg3UAn2iGbhg72miqbiMLv
    /q+dISgRG1Q0a1SDUJKBUOP4/NwWBIZkQ0xkdjav4kxbT95qIURpMPZ786GdD0Qz
    Yh8ToPErAMuE7gG+mDmjz8GtNL//k7MZgMzFg10KnQI4E9jjOxqbcHCtvX4gMrPU
    soOyEoL7D4XRyelo1GYpRYwo35YBDQjwhgxAbRjWwenHVnQq7V0/YYf5i0iJ1c79
    U+viy9+4U4AYu3b6IRLz5uIqKPBDNbdfwsLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524163455; bh=fG0Wp
    d0N4O9Bltvse7w4YLLmU4ah1oItWThtVdY8EsE=; b=TNnqWfMVmNevAQObw1ysq
    rEm95SP79fRVLP+H08Ziuqceljr1EwstH7xn+k7f+JtcMoMmc53Zz8jpoIvXJnRj
    iPZKOquISVOHCjYIc7DAC0YeCDefLN2nXAR2jz4fCDcXQ3zdHfJ2fQ8VLFe38aMB
    2/Pxqfbxhda/aIe+ZK/td8EDmEeEVRWRZxTc2UgQ4Pwo/rgkq03qiFWvtc9gXKzi
    eAjEAsKumRnniuJjEktCF0dqcvAP7bYQ3OrRwoRfsmxC1uuQ94uhgZPiWOsKr5fF
    wRExW2t5zFLp+WtFOMr6kjS5gSgrZ/oYQiu9QSbfQoNYUYF7Jod4Ja5LBc6P7UEt
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=i1TSyFX6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a6MHKiTM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=i1TSyFX6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a6MHKiTM;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAOiHEZ0GEV2pKWrKW4eEL6/Io5Atx65pPu1VMdscp0OELiKYGUxwQjNFCsBKtJh7eqHQaagMcfe+KqQgCQnW/RPT41uzFENzEWOZIBjKEEueOn/JD00
    FfeiBgttMDwOS/r9rM7Km0E+BLmntrPQ/4WM5PnZxYpF7UfDmubGZwaVe6NcKEK/Pcaf+cn/l7mtCGiUOEZRJznVSkacrvliWQ5HjX2p4UICgA4lTXs7FYS/
    TC7F2LFlKmoKkXgV2oK33w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=isjWbitoNnEehTF2FjcA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48N03teb8tEe62VeNkhPTmfLFYO+svZ0zFAdsWoUpeMoO33dEspCXIW9g1A+uzuiY9H9eZbCg==
Date: Thu, 19 Apr 2018 21:44:04 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 14/39] proc: introduce proc_create_net_single
Message-ID: <20180419184404.GB2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-15-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-15-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 02:41:15PM +0200, Christoph Hellwig wrote:
> Variant of proc_create_data that directly take a seq_file show

> +struct proc_dir_entry *proc_create_net_single(const char *name, umode_t mode,
> +		struct proc_dir_entry *parent,
> +		int (*show)(struct seq_file *, void *), void *data)
> +{
> +	struct proc_dir_entry *p;
> +
> +	p = proc_create_data(name, mode, parent, &proc_net_single_fops, data);
> +	if (p)
> +		p->single_show = show;
> +	return p;
> +}

Ditto, should be oopsable.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
