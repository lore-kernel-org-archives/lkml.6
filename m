Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3993364-1518393058-2-13453196375488247113
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daennl, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518393058; b=lxqeZgQyQ0pdFrgpjvaqOiV8w+xH/wsRgeyje6/HBuMKNBM
    TH2l5F0fh4IrGrm7+EntighEtBBZeWZJqY5VbomHJRZ6V6thrYS+T+EM+Ssab+Cm
    KRHqBJIZ5JfALVINQ6sfEOURDM7eLcFm62PX/EKV27Q57fQieUiQUIW84CTczl/U
    Eec7Vqy0JwSp1vxNGCcrKbQwPlQI1FPqmqcNrdbRuLnUrh8TES+2PHUWjHBjVv35
    IrRzTNG+eomndHs7pLVsMagAnZE8Q0vPqk5gKakjcFsgo4QhvAnko/J4JsfhGF3E
    qeON4ZhKkGjKNstGlFJgp7sujQdNOdqYY2y97uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518393058; bh=Y
    2l5joafKYdAN6ZHkfP2qdgcfN4J53GzCQt8SQhdJ3o=; b=sKUMn+3W1lAQWCO5F
    K73p1eDUN3a35ouSeOCbpTMAr0KfUxsi1ZSl3YmBTEKXv5TD82kfsAhh8ANNu7uO
    0PVHuY6PRwhmL8XrCCi84opgG3ViID/kO7XKMuQSEvjgpKrHDGqK9n7JdYwoctgp
    MYtBESVgDsoO2KLuL69GUJ7bMHjIgs6f6KF+kfreRfKnhcg6JQuyZ8oa6RDlCQh0
    QWigB3O9bHYgOi7X1aTV/Hfhi3rFUAlM92ERmxRU4b1F3rIvOc6qGr+yoLPTJHkT
    ssQ9qq4Gb7l0aWfjrNChvuhxY0pcCZWfOVFqIYJUi6J2vmu9EdnnmQ7F4QUadiaB
    nNEEw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=J88ZQGKB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GygIvudr;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=J88ZQGKB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GygIvudr;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224p3NAN82N1amSKpGClq+7CI7leb6BDyDXIDvrpWmFnlPUNvmPgtMt9FBShqhXIzKRoErFYBg==
Date: Sun, 11 Feb 2018 15:50:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michael Kelley <mhkelley@outlook.com>
Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Fix ring buffer
 signaling
Message-ID: <20180211155047.7859be96@xeon-e3>
In-Reply-To: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
References: <SN6PR1901MB204572CAD3159EB07D6F1043CBF10@SN6PR1901MB2045.namprd19.prod.outlook.com>
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

On Sat, 10 Feb 2018 20:48:49 +0000
Michael Kelley <mhkelley@outlook.com> wrote:

> +	u32 delta = rbi->ring_buffer->read_index < rbi->priv_read_index ?
> +			(rbi->priv_read_index - rbi->ring_buffer->read_index) :
> +			(rbi->ring_datasize - rbi->ring_buffer->read_index +
> +			rbi->priv_read_index);
>  

Would it would make sense for this to be a wrapper function like other ring operations?
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
