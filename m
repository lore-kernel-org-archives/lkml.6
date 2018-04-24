Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AIpwx49GzVn8yL0AVsl1Xb/lHAseHDCUGZZHN48D66eLsS4DzaJ2DBst8ZCGqOsHV4z0rb/yVyt1
ARC-Seal: i=1; a=rsa-sha256; t=1524579451; cv=none;
        d=google.com; s=arc-20160816;
        b=VEqg6m96JRwJCw0DqxbAUShktrm5YlflYIVNUB5kVMZGF3rHCG9e//RX7LmxkFjSnH
         E6osQdt5lXHg/XdZpo8rbKLFmSj+OVFtEpz/WQXC+GVsfxAJWtigquesKpmgPsH9BgCV
         5hLQtgXGf7D1OYABUIQ3iPeYelO9QOSCQF8UNA9bcvJf5GkVjSYIAgYvGYW+VSV3aEsb
         2tQO7FBImmWQW73JWITorhEOLmJsdQS2vV9gZnPpLE8FL3Sl5c6s8u7/66riMJz6nrKe
         iD3GyE0bk35xaN2ruJrJN2+qMd621ZejJaEmZBZSXtXVDArhyM6E5TfeWlKPb32qivuM
         hVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=lZIAio7UamthvYXqJFBO1Oa2GaIU5xvHLSfQitohI7U=;
        b=rnQRUIX9iZ3xdavsv9z7QZLyHM+sOEFSUq0+jKHjt2m9rILAGTD8+Ew0AthXXmgLPW
         PH2+In3OTR8l90whWeMTtXz3a+bfHUx1Eu4Ump1NT82Ree7PbrGOU5w/buYQeczoAGPM
         XSSvXW2elknNgp8VKiS9ZEat7qQGLRWUkYj6u9XqrQfKZZdetOZIDCaA0rrGm5fjFRVa
         dCAdYKHfLBKfzUSaTLh4LjByXyVFfLs9M/jvoA/3jOdrUXp/BTLBrTNvx7H8Uj3FuXrI
         /9wAfAvQaTS/PBsyxs/8r3aPXgNafhhYVfrKF/GJALDave+O3uoUIiFARdJ1oOqhS1yn
         hA/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Tue, 24 Apr 2018 16:19:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-rtc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
	linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 03/39] proc: introduce proc_create_seq_private
Message-ID: <20180424141902.GD26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419124140.9309-4-hch@lst.de> <20180419141818.pjys7at4xmz2h6ho@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419141818.pjys7at4xmz2h6ho@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178425260316067?=
X-GMAIL-MSGID: =?utf-8?q?1598637423607967802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 05:18:18PM +0300, Dan Carpenter wrote:
> > -static const struct file_operations cio_ignore_proc_fops = {
> > -	.open    = cio_ignore_proc_open,
> > -	.read    = seq_read,
> > -	.llseek  = seq_lseek,
> > -	.release = seq_release_private,
> > -	.write   = cio_ignore_write,
>                    ^^^^^^^^^^^^^^^^
> The cio_ignore_write() function isn't used any more so compilers will
> complain.

No compiler in the buildboot farm complained, but neverless this
