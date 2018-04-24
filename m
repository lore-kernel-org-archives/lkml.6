Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3158210-1524580059-2-13492983822429065807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524580058; b=oqAHx9i8vN/0apnmP2yx7BbDkGjsvuI60Lm3JWiP+Fyqyw4ggW
    B6wIKZo2YVdiIC0eub8kaNjyX09zRfiyYiYj08YoTe8xZZv7VX/bwMRrpGTJvpsp
    CfdCQ7/oK8KIDZDBTgGpoNvkraCVfZE6ktlteUeghZ3IChgOc+P3UDAG3U2pXZqK
    VeKbBpqPZ/4E6MEdDtZNMiVB4KEsWoYYX2H0MRYSmaCqIW0fgNSRNqRqzMyntgtW
    AhJvqKiQ+GVjveeoUkNYFpyP8lphfy4v+tbq34nRDsvjk9pcKLUQSI1iAi113ocx
    CHA7TU9HaESsCo1xi8r3wfBhR+iFYn/45ZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524580058; bh=75ral
    4FmNJQhNIIqvD3rby5foROig13U/Pm/trfgIVA=; b=wdy1bHGkxXpbAWLRRoerG
    jrawOoCVjfDt80ScY00ahl5p6TSVTRcqJn3q5O26I8zVfoAFgBog/jA4KOCTQ3DW
    zQpIkTUJlffq66RK40C7OsVYsuxOS5NEg/y312XQTvbFGbaEe+6gdfCDMqTFJqKL
    2KbjyWBiYODJ6jGdDmytGeP21UVUZjUO63ujyAGDcWrYkZFQR29sHQKjL8zB7ZSs
    PYhP9Y0dxG+aSDtMp7KDAARtNW7C+U3fxXLmQkbF4hZy8W37egNlgJBwqeq4547V
    YAx0Pl/VwS+lpsfLxoyut+3p3JqgIvEQZaDHtij2kfAhKNtCTrw0kzVDAm27OL0V
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLASrjFcUVgqxXIzoRMpFsi+/MriR25eGx/NgLBLDXC8QK8teT5uf1zRq/Z3YsKVjqKYR3Ok6VuZuzmJu9oJhXQ3V2ENWuVi58h4b+c7vI0vRd1AUM/h
    Mu7DJNjaXmbVuejxtpAzb5fFn+k9mo6s8Wo2b/6MINiCwzRIaW6OmenrQvbN1z1V90K+CmYWea1jLb8NLiAiXyXb6/HR7XS0d+6+WyKI8SgQvEInqhj2SJHT
    zPr7NTOA75b7MtlhhBqOzg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=6iVoeZNcpjrGTumrqMkA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 24 Apr 2018 16:29:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 03/39] proc: introduce proc_create_seq_private
Message-ID: <20180424142902.GA26554@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-4-hch@lst.de> <20180419185027.GC2066@avx2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419185027.GC2066@avx2>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 09:50:27PM +0300, Alexey Dobriyan wrote:
> On Thu, Apr 19, 2018 at 02:41:04PM +0200, Christoph Hellwig wrote:
> > Variant of proc_create_data that directly take a struct seq_operations
> 
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -45,6 +45,7 @@ struct proc_dir_entry {
> >  	const struct inode_operations *proc_iops;
> >  	const struct file_operations *proc_fops;
> >  	const struct seq_operations *seq_ops;
> > +	size_t state_size;
> 
> "unsigned int" please.
> 
> Where have you seen 4GB priv states?

We're passing the result of sizeof, which happens to be a size_t.
But if it makes you happy I can switch to unsigned int.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
