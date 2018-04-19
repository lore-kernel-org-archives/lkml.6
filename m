Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3804898-1524163838-4-2161554636080614483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524163838; b=UFCur6cuFalnPPMPa14ld0gJT6USglkCc5eMTO+IiEMx48XBNJ
    uGs3m4RYTQF57b+qJlh0V0mo1EEDoL9994pkcda8gTpLp6gAEy0JHAjDZwSSFhMx
    R4ysYBWj2O8D7nqYPkHy/iirR1+7LVMi+6WhJrtl68bbEW+kt/cWhYTCpeshI2G+
    IXLHjN4AfSFVSGV5mZEhOXfxxiXwLyNXRWAli7DDIDHyPbCnY+Y+OZLGB3ZsNPgg
    Dg3Bu1qXgnFBW9wetxohkauO/fQQzsVJnT1LmPXbAAXBMmz6nRFQDN2Rb4dJf8G+
    9CXZv3FbH+FxJUEJT74jo4wDrH1myxpm9S/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524163838; bh=Y1IW0
    ItIMokUBp76fKLOmoOvHwX32rNQAsuCrbnuYYs=; b=mtmw/IP2NrfZZO104gvZz
    SBXYz+ORynmbHF5+o9FsENqIItgVhVzCi6SlHyF9l5mJXnKi9VQqviZOZlJ7ePOo
    7NV2m5Fk9QRko0erRSsaF4jW1r+jtalFYNWCr4zZnBz9bso/wqaaSlTSd3AXl/1G
    +iVuCEIHHr67aUJkQ5IbZgoHHLpAtOGQmMJq2EEE9IPqiVraoC+8uBcdbgzgb8+0
    ylfXk3I395DZP/2RCtFqENna2BJiwkLM05lkQ2OSfku+gSZYtM3Y29/ZTHLtnALM
    8ENzWfi5FmNGpxV1TlXyNEb28B23alRYsEEThReXRo3fm1Uer3JPtumET2ecUjXS
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BhlihW61 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PIIlGrib;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BhlihW61 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PIIlGrib;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEC5GtoQJFX42xeeMU5Rln5x0x3HGG2gBlQcSfzupaAX32CKXqBsBaclTcYGtOa1VYOi7rpT54yTAIN07Meor8+Vhw1PTfzLeatnYgoExiVCqMNr9oao
    Q9uPkQwFqz/2G2CfypvX2m5lPYYPhLgenznA1AGjCpQjTZrra0pqYXz9bmqYK7o6cCnr4bRXhEcijpjVg6dq8LsvgXVJU9se6N4ZeZTHsEZuNyqm6dMi4G7B
    oKwPxILJBC8tgKRwtxZ/lA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=kyN4xk9p7RZhtwsr1yYA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48tC9KrpQlZSk5d28O6uvX9V9rUlGPmz6aO3+ASAV9dgEmJRar+CfFKnKfRQ1dSYVy+coSpKA==
Date: Thu, 19 Apr 2018 21:50:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/39] proc: introduce proc_create_seq_private
Message-ID: <20180419185027.GC2066@avx2>
References: <20180419124140.9309-1-hch@lst.de>
 <20180419124140.9309-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419124140.9309-4-hch@lst.de>
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

On Thu, Apr 19, 2018 at 02:41:04PM +0200, Christoph Hellwig wrote:
> Variant of proc_create_data that directly take a struct seq_operations

> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -45,6 +45,7 @@ struct proc_dir_entry {
>  	const struct inode_operations *proc_iops;
>  	const struct file_operations *proc_fops;
>  	const struct seq_operations *seq_ops;
> +	size_t state_size;

"unsigned int" please.

Where have you seen 4GB priv states?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
