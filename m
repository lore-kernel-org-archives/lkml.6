Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2567741-1520927001-2-2751227003231684826
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520927000; b=pkTEoZnWy5sDnukFHFsm4RZDpJyLtJDQb2XKE21gEtN9qWp
    I56ai+4awXNFwoCa905sV9FBalTBVKYOoAicMEQ6K0FyiMtwMTxgdm+QFbpA8U8S
    R9YaGQ6z5ime5ETyOe7em+Iir+YmL/+xU1xMxIemCWJj2iy0fOugMP7PcRcWATOf
    FOmBQUvBoIni1cxBusiYXShYj7EMO4lBEfOu3L3gKiHc0OI9a8K0yKsEjIpPXqSY
    qV0LGsE53ElTjS2+Mcg11ppZo9NVgfjN1SsYnlXJcnHRYQBqxRbJlsPb2KhCyPdf
    OWTvW9l9QMkbrWG489JXsYVLgZvD+F1bo7fWDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520927000; bh=/
    7IRFLmtZHJ87L+zJ+VlGa9GcM2wtuml9bnw1YJQWYU=; b=TQ9OEF30NLDvtWn2Q
    Ux5vzgTH8BI5fJDZtU8IeEmg6CoNIiPdvpaOPs5KHOIy/Jc9wXhpcBJGKK/Ug9JQ
    8AvsSP36MW4TrdIbmD4Yy3SwWk0f6TjqHte67+kMrsQMKU5URB4vZMeBrKr7dfaE
    p4AbKha0b7I9fIn17AZ0OGHi9F/36NC88a091cKZFZ6hXVga/1rBP06efkExk/H7
    LbF0HrORlWHIMTDfFlfI4wAm+fCtsZ7g8yGsAl+LSMgz/MnPhcu9i63ChvO4Us2w
    wYn/u5TbarVLpcJqUI70LQDynuu3Y8y+xME8GrELHuTzV6Y3N1G21/gbsoa90D1g
    s/gVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,464,1515481200"; d="scan'208";a="12257187"
Date: Tue, 13 Mar 2018 13:13:04 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: <hariprasath.elango@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: use kmemdup instead of kmalloc and
 memcpy
Message-ID: <20180313131304.47d457e3@ajaysk-VirtualBox>
In-Reply-To: <20180313062049.6200-1-hariprasath.elango@gmail.com>
References: <20180313062049.6200-1-hariprasath.elango@gmail.com>
Organization: Microchip Techonology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Ganesh Krishna <ganesh.krishna@microchip.com>,
 aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 11:50:48 +0530
<hariprasath.elango@gmail.com> wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> Kmalloc followed by memcpy can be replaced by kmemdup.
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>


Regards,
Ajay
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
