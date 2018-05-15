Return-Path: <hch@lst.de>
X-Google-Smtp-Source: AB8JxZo0ywP8cHpdvCnhct2KOThOebIHY2SwpcmNOJeuYH8uxmoh+pl5SlG4aXEYuLsSZ1fhXP2l
ARC-Seal: i=1; a=rsa-sha256; t=1526395104; cv=none;
        d=google.com; s=arc-20160816;
        b=n9vUHTMQm6rg1kK8bUGrhVGsVyyTdrAfv+n/D4MDYGrUfyBI30uzZ5wBM0SsVIy635
         XQCTv9WFvOuZSMJ+W/ljwj4cIiCBKNHbHNMIhI7ZhjkzWMKiI5FPaY5n4n8UULmC9U97
         1XuQ5pc54fD+ONnTZQsAVs4qCJS0BsvCpCBCfpNZx+1e3zyU2Tp+yBDCwDBaS5qxii1C
         qHxoWZSjHCA/K6y5Ok+UK3IrpuxQWtFMYdSvS3yS/h/zDT2wYOdq6J/kv8gLATk9rhOO
         qv/xo9t1XJ2M/DEIhgUklZxKJfDoBFJUZmVtVEBpAx9HQRBoyVaa83teTp7WpGZ/ryys
         sV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=eVBZYBcVqXscWRi9mXJ14KStLVIBiu8pSdyNe2jSBPw=;
        b=PePWmZfPyCnc0jJTDXpKEsYtYurm62YHvEnMRHfXeo7BiTZ13NJWIWtVv4hY6HNfPQ
         Q1RAZhLN0/v4lQCj3un3MlJFfQW/qwCiJeSuqxdByoba4LTJWgshou/ElJvOipp5R2MC
         SFlkjugSxlZwPCfrG4ZfhwHwwek7vBTjkGNlWs5TdtZW8Hr6pCu1wralBvUrK+2WvoU9
         dY9HmgCVhjNd9oJfvRkQDczkP41O3CLKne66xkVriygVWkcTztVvLA82910Cm99sDiAE
         gR3NRIuwTQMoMcamTNLJjI+HsQM8W8mXjeA0FNirQcjDjE45Ih+gk/LkJIRhgq5/XAKR
         HQSA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de
Date: Tue, 15 May 2018 16:42:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-rtc@vger.kernel.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
	linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
	linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Subject: Re: [PATCH 04/40] proc: introduce proc_create_seq{,_data}
Message-ID: <20180515144244.GA32583@lst.de>
References: <20180425154827.32251-5-hch@lst.de> <20180425154827.32251-1-hch@lst.de> <26540.1525094365@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26540.1525094365@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598733765638743356?=
X-GMAIL-MSGID: =?utf-8?q?1600541273085733030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 02:19:25PM +0100, David Howells wrote:
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > +
> > +struct proc_dir_entry *proc_create_seq_data(const char *name, umode_t mode,
> > +		struct proc_dir_entry *parent, const struct seq_operations *ops,
> > +		void *data)
> > +{
> > ...
> > +EXPORT_SYMBOL(proc_create_seq_data);
> 
> Please add documentation comments to exported functions when you add them.

None of the base functions are document, and we really want people to not
use procfs for new code anyway.  But if I get some consensus from the
maintainers and the list I can throw in another patch to document
all proc_create* variants.
