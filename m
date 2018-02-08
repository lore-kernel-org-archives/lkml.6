Return-Path: <jgross@suse.com>
X-Google-Smtp-Source: AH8x226XkgUwyNSqIMI3/WohFBd8WahWT2+LBSiAX1CUVfdX4LM+k6tzA9BGxWh0MkpV9kd9+c+C
ARC-Seal: i=1; a=rsa-sha256; t=1518079786; cv=none;
        d=google.com; s=arc-20160816;
        b=zGdhIZ0u1nrHmW9eesmtyF2XprLbU9hysEj09Dwv1mD/lmcqfrIdTzSMA9QlH8smtY
         +wX1Mi2Tnag9/7t+9vGpY0aFHM+xhzMQKHLl8jjK1te0K1Gs1WrwD3pSSJHHRICAEw+q
         6JRppXnkxAK+FrBmCxfSLNED3HFiMYJOI6+rvDPofVXHpnlQzXZm9RMH619iYW9GAgcU
         8kqO6at3rW+VKFVVhSUuTacvyudRIFXo8UmQieD7iFbFNgT8lb4/U93k6yW2oMtIJHzx
         6BXb4bvb7V15XCiEE6Ljn9lOhceIL2nFsIsYfA0sniAoKIF7B3yjMY3im7NgpUE6HuJF
         GWOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=A3yqOgPrxhFq8l/c9RvUyXcq7HfJEfSPj71mgkNT2mY=;
        b=n/8ltA4KmM+c8B1nuXukvZRDxJy6/4Fk7uTkKDiugoYsAn4aXecJuDgR0JLI2Z+M5z
         oS2I4jeCXSK16wM45ZMgCNFCiYtwXt5z0pvG5CD4KBJ+7wOoNkxqwkV6P989LxM1ChLG
         5LZ8Ody0hLWuwEXrVcykh13r7wlSuC9TLhMN2QRp+FgERj+KMQFaAxeO76xEP3yR3sIv
         MfXzWrxiy2+IlCH88WZCActpgPwFGTKJQYQml5Xo2B6Q7wZCfN85aZF68pJHdSPG0jG6
         mQOAsWE/mZ0saxmujKF6G2FcK5gdzHDaNZ94b0sTkro9bFzmDsVMUoRiyoUD6PxIm01B
         HQpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jgross@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=jgross@suse.com
Subject: Re: [PATCH] x86/xen: Calculate __max_logical_packages on PV domains
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Prarit Bhargava <prarit@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andy Lutomirski <luto@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, xen-devel@lists.xenproject.org,
 simon@invisiblethingslab.com
References: <20180207234923.13544-1-prarit@redhat.com>
 <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <0e2775c8-2114-e554-dd0f-7222300e3e27@suse.com>
Date: Thu, 8 Feb 2018 09:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <5607eaea-5cc3-31a4-9685-1d7dd147f564@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591788037595473599?=
X-GMAIL-MSGID: =?utf-8?q?1591822030423133662?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 08/02/18 01:59, Boris Ostrovsky wrote:
> 
> 
> On 02/07/2018 06:49 PM, Prarit Bhargava wrote:
>> The kernel panics on PV domains because native_smp_cpus_done() is
>> only called for HVM domains.
>>
>> Calculate __max_logical_packages for PV domains.
>>
>> Fixes: b4c0a7326f5d ("x86/smpboot: Fix __max_logical_packages estimate")
>> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
>> Tested-and-reported-by: Simon Gaiser <simon@invisiblethingslab.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: x86@kernel.org
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Cc: Prarit Bhargava <prarit@redhat.com>
>> Cc: Kate Stewart <kstewart@linuxfoundation.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Cc: xen-devel@lists.xenproject.org
> 
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Thomas, Ingo, are you taking this via the tip tree or should I take
it via the xen tree?


Juergen
