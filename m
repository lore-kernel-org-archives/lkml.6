Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1097881-1525700333-2-15877673792854882181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525700332; b=XxoWVTtepNPa8aC176FFhQ6GiDL466TJBMgkoVYh9+A2oFbaaX
    3Nib2U+PFvmORAYGHw0IjAlNdGydURYZnfFcS/cddHldpVmr26Ny9DpqTE9v3i9l
    m6QqbPyTbK2a514HIBH7uKBfVdd/YYzqTbi5z06GkmPjG7FIbtGDe3eeJZ3QxaHS
    Oyy0/NMT9P1WSgDtbC0LcvCo74IIxVu/kxf3m2uG0+tluIeLRzeuM2caP+G1ENBk
    f2W+VZQcYUoN6ublYmHqrq4SGjRJuNN5RUELENhOxK0ds0+eB+3Mo9reie+551nt
    x81eCG/yvzWbzgnpNkWt5YJdLbogwEsqXy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=fm2; t=
    1525700332; bh=SeOiVwU6zjZDXJ2vBP75qe+PYIpgfuMffbhWI1DSd5U=; b=V
    v9LysW44+L5n+vCliQqx5PDtXL0e7rC8UNvJqr8oW2ppVy2tERKhIHZaj+dPXlG8
    /w753/FZ5afNabbi/SRz13Wq5ieZUkKOWiqqFHywthbCZSwrPsdMMCsppeNxEbqr
    FhvcNW+JwjieeqrnmAWCyavBxh+Amv37O6XBAI4ayhKXnsSGlgysZPMlMyuW0DV/
    wGQgKSGKvviiRznLQkjWItvS4DhpHSxYsRins6CXmGehx2ZMnnijY3CcbKMtBLMC
    C7suVrUWDzcePi7MOOsSmxhVqzdHmlBr5KC7LfHsto0YHPB2dn+U5hH/54XhJJxn
    vZt/rBbeiiewnEmyY60og==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=V3TsOEAu;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=V3TsOEAu;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=redhat.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDWDqBh+g68OzL1aucLIiw9vSoMOB7JQJOURMyJ2fU75pC6rQEVz1ewxsv0r759ZkmE2SBBjkHvH17hF1Hqs44u3VHQv0An3gaq+ZIAMxLsy4zEDIBsL
    AqwnQ7h4isP8zUEqsNkA3WI3dFW1JkJLMjgJuvcDnG6MxdOTJ7OfgeCFvvgeVOaL4pZoZDjDT8X5+mfc3uHQOVq9SDjuU59yCL58YvmV6vvhFoiF0aLazkdU
    pIbI5YxdCM7W0+R6jXqTqA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=DDOyTI_5AAAA:8 a=J6ulxgwZo8azD8rbA9QA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZosgdNa6RjBKkX9aHifCv0RIUD+y5XVs2ViGlYnqEqUcBRurZz0XAqvFe0NOcikmGP671oIoA==
Subject: Re: [PATCH 2/2] staging: android: ion: Remove unnecessary blank line
To: Nathan Chancellor <natechancellor@gmail.com>, devel@driverdev.osuosl.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <20180507011854.12627-1-natechancellor@gmail.com>
 <20180507011854.12627-2-natechancellor@gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <4dc477ae-4f62-e344-26f5-133f0c043b14@redhat.com>
Date: Mon, 7 May 2018 06:38:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180507011854.12627-2-natechancellor@gmail.com>
Content-Language: en-US
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
Cc: Todd Kjos <tkjos@android.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/06/2018 06:18 PM, Nathan Chancellor wrote:
> Fixes a checkpatch.pl warning.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>   drivers/staging/android/ion/ion.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index 269a431646be..d10b60fe4a29 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -95,7 +95,6 @@ static struct ion_buffer *ion_buffer_create(struct ion_heap *heap,
>   		goto err1;
>   	}
>   
> -
>   	INIT_LIST_HEAD(&buffer->attachments);
>   	mutex_init(&buffer->lock);
>   	mutex_lock(&dev->buffer_lock);
> 

Acked-by: Laura Abbott <labbott@redhat.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
