Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4183612-1519690213-2-10091829791733143288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519690212; b=RYh+XlNDY48v1bkg/yXCrDmIHB78DQ8HJE/RSwm2m/GZIhv
    oO74Z6fzaSApFS1/xXNs6OXTBKE90B8Zsgla2JjVW9vRmy7DLjOZ/d5AHSc07Ou/
    vUrVpBEifDrW2dYARZCfkVcOQsdXCw1n+fImG9RJuhufT/i1foYTcS/T3JAHN1Xc
    c6WoI+le7FzkbyTc8UxkvL+klZozAALV09wPWiIoWL57SYYhHk0roCmmq0wyw/k0
    oDVlt7Z17gI4YLp7PjhuXw8LkRUsnM/jmGJJMOhsIWmgspZ/E10g/Gs87Z/nTjkQ
    +SnY4NKTySNgDC5fXN0K6cjmaWB6bjopM91diXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519690212; bh=s
    1YnGmdmBnO6OOQnlsUuFKK0uiFWBHTPrVCkCUT7+F0=; b=AN2RM55RGg0+NQcL7
    1HUsIyx06YOv5bWrCM+XAjlEv/ckx3nWTi7DRX2oeDJJQGuv7vXUsHrD9TYgI2ED
    Y77XtycEwVPh1sqOsQePg05jodEqXrNv2GuP9zCQcIFdSxfvBVj7QA4paTEOYIhq
    1NFeJea/wbPEpHn40N3zFB4tRTulyqo+py0PWhChVkvX88Fm/8sH56yQvLXMU/7+
    Gp04pC642BPCKO7S7p9d6PNk67g7toFuIxszb35grovPcBD2+aU6je0KHb3X9APh
    vXuNUcItlmJO6YIodMBNJUnD/AOEX0+O9kD1X7mLOq1UdXQ1X1fyfmyiDymWrS1S
    TV8Lw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=LW6Qt4ZQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F13Gvnyg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=LW6Qt4ZQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F13Gvnyg;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226y6uFsWJ6K5KVOmQ2SIrmyzIL9Yzfu6WgA6kFWlBcg+zkSyuVXLwXPDCNqUJtbwMatZ/HkEw==
Date: Mon, 26 Feb 2018 16:10:00 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michael Kelley <mhkelley@outlook.com>
Subject: Re: [PATCH v2 char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Message-ID: <20180226161000.2b7a7214@xeon-e3>
In-Reply-To: <SN6PR1901MB20450EF7C8CC4112381274B9CBCB0@SN6PR1901MB2045.namprd19.prod.outlook.com>
References: <SN6PR1901MB20450EF7C8CC4112381274B9CBCB0@SN6PR1901MB2045.namprd19.prod.outlook.com>
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
Cc: "olaf@aepfle.de" <olaf@aepfle.de>,
 "sthemmin@microsoft.com" <sthemmin@microsoft.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
 "apw@canonical.com" <apw@canonical.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018 23:05:33 +0000
Michael Kelley <mhkelley@outlook.com> wrote:

> Fix bugs in signaling the Hyper-V host when freeing space in the
> host->guest ring buffer:
> 
> 1. The interrupt_mask must not be used to determine whether to signal
>    on the host->guest ring buffer
> 2. The ring buffer write_index must be read (via hv_get_bytes_to_write)
>    *after* pending_send_sz is read in order to avoid a race condition
> 3. Comparisons with pending_send_sz must treat the "equals" case as
>    not-enough-space
> 4. Don't signal if the pending_send_sz feature is not present. Older
>    versions of Hyper-V that don't implement this feature will poll.
> 
> Fixes: 03bad714a161 ("vmbus: more host signalling avoidance")
> Signed-off-by: Michael Kelley <mhkelley@outlook.com>

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
