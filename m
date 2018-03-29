Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-551127-1522320836-2-551669497404465095
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522320836; b=YHdnoGw2GC7Us5ZunhStiz0D3Ssm0AKS9tkDis+eueZVD741zB
    o9nc9tJAkFp901HwnLN0xrZsBe8n4fX9OA27bz4H+NTz+oaz+778lK6JIPGCrVhg
    8Fqc0O81GZb2zfWw2S+C67C3UVyHN7t03/t4ZFj4w2xvMUZAZL/781wUoPw1iurt
    A6sfSD360VSsdOWEfnSAExKOlneoq6+BNzDEipkSar5XE9/b1ogERKVUeRLiip86
    l4dzs4JB8AF35YqGIBGvYzSd7cJ2m1Tk5R/kr1ZvXE14xQf1VuXiHtrH1AbyPF7k
    lEUECTZxWrfAAImPqd+oPK9en62CHR9C3nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522320836; bh=bapYI
    lv8hfcaKif3U2K85ev5kIwfihuKtIzfk76fmRU=; b=LQXV+JNA+qPcWwMRUW1by
    P/JKRF/Hb/JDmdAp4v/lK7YQDn0YBmBX82aT/JPdIXbRd6N7CjxsUxj9EVJuob47
    PFzpkgtComczFRL2vQAu2r2DtvN+tMAxImwou1puTyMzCPFNkHKo1JdqgBMaa3SX
    uxxd19x5eViqzYJ7tRqx3B/EaT9U2kiSVBTPcZbQJ0ULLwWUfKUvdhKQU4E1trhv
    Epz84UM6op4/H5dSQTuJFfHNahP2Vfc5v7zK4X+TcZhFdJ9st8z9PNM3c1qTxfhU
    BtfjKlKTiDOcN/pS9Ac4FGc1vRbw8Mv8R82pq5aqpuYDIUZP4uWqOCK82iJNtVEi
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cwj0hHf5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eFWiN+gA;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cwj0hHf5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eFWiN+gA;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNpaFITrYAdkjZNdK57jbbKabitCOGf0Qvi2IYDt6aEugxz63BNmOvwehspl30aGh3m2buxITGZWA5v6aIQkHTEqUXaY/hE1FSUqpJYln6kK83DipMms
    OCbJQ04XgCl3thz1ETslP7u7mKm61NJSrUvsl6oB9ZKbzz+V5dNOVdR4ye1cuHSLMPoXH0W7zhxNGfH+AcfB1J3GfrdcDHe4aZaiscjq8LXDWqO1fZkJxezs
    zkxtPmWQErwrtkAaviBcEQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=eJ6nSM8dspYA:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8 a=ZjMmFbqLJUasaxWm5-EA:9
    a=31LAJmlPoIa1FvKr:21 a=wGiPyTfnrXHOABbw:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+QEG8zljs2pm85Dhv2tkwWc0gRd3WfiZ/OUqCDlYQqvaw2LK2/q2wBwlS9J/uyxVozBA+icVALU57iX6dVtcc=
MIME-Version: 1.0
In-Reply-To: <798fbe60-52aa-4fb0-0cd3-e2c067bd6c04@gmail.com>
References: <CGME20180329072248epcas2p3d12617d41e964252998dd1d34f740a97@epcas2p3.samsung.com>
 <1522308157-26463-1-git-send-email-ji_hun.kim@samsung.com>
 <798fbe60-52aa-4fb0-0cd3-e2c067bd6c04@gmail.com>
From: ji-hun Kim <jihuun.k@gmail.com>
Date: Thu, 29 Mar 2018 19:53:25 +0900
Message-ID: <CAC_4WJPH68DJm5ofYcGLqbF7wnQTvL7uzhkakaW9hUzk-ZhZFw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: vt6655: check for memory allocation failures
To: Jia-Ju Bai <baijiaju1990@gmail.com>
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
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com, gregkh@linuxfoundation.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, Ji-Hun Kim <ji_hun.kim@samsung.com>,
 forest@alittletooquiet.net, santhameena13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-29 17:00 GMT+09:00 Jia-Ju Bai <baijiaju1990@gmail.com>:
>
>
>
> On 2018/3/29 15:22, Ji-Hun Kim wrote:
>>
>> There are no null pointer checking on rd_info and td_info values which
>> are allocated by kzalloc. It has potential null pointer dereferencing
>> issues. Add return when allocation is failed.
>>
>> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
>> ---
>>
>> Change: since v1:
>>
>> - Delete WARN_ON which can makes crashes on some machines.
>> - Instead of return directly, goto freeing function for freeing previously
>>    allocated memory in the for loop after kzalloc() failed.
>> - In the freeing function, if td_info and rd_info are not allocated, no
>>    needs to free.
>>
>>   drivers/staging/vt6655/device_main.c | 64 +++++++++++++++++++++++++-----------
>>   1 file changed, 44 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
>> index fbc4bc6..ecbba43 100644
>> --- a/drivers/staging/vt6655/device_main.c
>> +++ b/drivers/staging/vt6655/device_main.c
>> @@ -539,7 +539,8 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>>              i ++, curr += sizeof(struct vnt_rx_desc)) {
>>                 desc = &priv->aRD0Ring[i];
>>                 desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
>> -
>> +               if (!desc->rd_info)
>> +                       goto error;
>>                 if (!device_alloc_rx_buf(priv, desc))
>>                         dev_err(&priv->pcid->dev, "can not alloc rx bufs\n");
>>   @@ -550,6 +551,10 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>>         if (i > 0)
>>                 priv->aRD0Ring[i-1].next_desc = cpu_to_le32(priv->rd0_pool_dma);
>>         priv->pCurrRD[0] = &priv->aRD0Ring[0];
>> +
>> +       return;
>> +error:
>> +       device_free_rd0_ring(priv);
>>   }
>>
>
>
> I think you should return an error number here, because device_init_rd0_ring() is called by vnt_start().
> You should also implement error handling code in vnt_start(), and let vnt_start() returns an error number too.
> The same for device_init_rd1_ring(), device_init_td0_ring() and device_init_td1_ring().
>

Hi Jia-Ju, Thanks for the feedback. All right, those function looks
that needs returns
an error number. I will implement error handling code and send a patch
v3 tomorrow

Best regards,
Ji-Hun
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
