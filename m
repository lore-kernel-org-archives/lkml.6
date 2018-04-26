Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1619581-1524707662-2-16933799210712570897
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='au', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524707661; b=Jh0HnUZNLs/+A3MLGpWnD5ByvoNy61gOfUBcvq9z2ISCvcbwJu
    g1+0yNcqQdl8q2X4vu64ajlapwSFvKRpgrRWIj3gtXWXC+i2QDfmqu6d4Br/LO1e
    N40Ya5gWDc7Y983O2RbKwNAQsl7y/OmVThu7Gwa/LAQIdEfWdGG+bhoU2fH8j4qU
    cxzZXn6LnBhpmYKe+scMJeKkLym9ZfeZqV+7ctFFBuZuBl0hGMMM75//fixe4qbt
    3PiLYVpnx+d44KBXln9z96WenD8Y7ab3b1OPjGJLK9dMvi/MkiWxOVNA0JoOKsZG
    guYkgBQR7uowbq8TEFvTT0s+KC3b32BaHkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524707661; bh=kPmg8
    q1/uKA1soUhaD0IwIc9a7wWXnMaYKTbEbg+SE4=; b=GTmk8OdLbj27XoMNyNDbj
    bHeGNMo1qKhk9yQ7/NRA8uI7gGN9Z/kZjG9Kubn4gNPYoCDuZFk3svw5NHtOcntb
    QphGpiFc2xQLyrsufsMWG4dAe6k1keETYTbtw+fgY+qbzqT5HmiD5zqZkQqNw0nw
    dQC43zSuHFx124X2m315AbUjpK3KMH/OWBpemy0nK7O8Vi+zQGDPJEcoX8sOfCks
    x+9vCu2xdDBDCsG9vEmvdn/xCIvNaZEy8fZYY22KKUfRnW5UJu8MkGzxnFxKwG7D
    7VVXNjF2Yfd9GG+yq6HqHQl/S+/+/3m6OZXIdWtuQXu3kWiWwv7skl3JVnrZB8gM
    w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=telegraphics.com.au;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=telegraphics.com.au header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNhIQyJGqTaKPR3asIfxHmWt53fJB0so/7DdY9DVgzwGcEGLm88AxDnxEHVnbxWIoOxxwkgqLE1j0YYaO5SOEJ/C3gkRNNebIcWo8AxKLXRVcVmgwG1z
    sPDH7dUcAuLon7A90FXOZYPtUHqhmSfYSf/5d4CDjHppElQlq2Q0OfK7j2nphjX6aOD/+4EU5z+8AZiQIyCipC9TqFXcv2QnMuBtlPvmwGnO/FjMqaPLUw9r
    sExQjN1GQqe25Z5s5UCs/g==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=VbQh5UYEud8E95Pp_A8A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 26 Apr 2018 11:45:50 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/40] proc: introduce proc_create_single{,_data}
In-Reply-To: <20180425154827.32251-7-hch@lst.de>
Message-ID: <alpine.LNX.2.21.1804261118050.8@nippy.intranet>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-7-hch@lst.de>
MIME-Version: 1.0
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
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 25 Apr 2018, Christoph Hellwig wrote:

>  
> -/*
> - * /proc/nubus stuff
> - */
> -

I don't think that the introduction of proc_create_single{,_data} alters 
the value of that comment. That comment and similar comments in the same 
file do have a purpose, which is to keep separate the /proc/nubus 
implementation is kept separate from the /proc/bus/nubus/devices 
implementation and so on.

-- 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
