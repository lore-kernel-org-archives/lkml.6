Return-Path: <maran.wilson@oracle.com>
X-Google-Smtp-Source: AG47ELsK4CYPnKLSCWTAmaa29Hb3KbyyffW8mCB70pxsFj8puZyHFisGiMBCmtS6UY2HqkgY1iPO
ARC-Seal: i=1; a=rsa-sha256; t=1519924832; cv=none;
        d=google.com; s=arc-20160816;
        b=MdbqQ9yX7kydSTj1LlhaBvO5CyMeY16t2LvM/Z/birMHkOBuG+4eX59URFIO6QNKKF
         wuhzdfIPLeeloQxFBO6fURGMPRNfQy4SoIaH6d8MIpIGcP8YwVRKtaCDLIEbPIehWqmu
         nd8Q/dJewk+F/tWiW35XmOnSfX5n4uqYgFoJ8ClPXcinznZ0DDjuSTVmMIHlATFHOni7
         veeBLuzg243sjE+kWINMgGM5Z+TQqzHeOQ1mP0xSdz3idzyedQ7Fxndk7u4+9oC2mWFg
         UEPIFo7RE1ZAlLfyETaf/NNgQLlFY/GRt3U25wMtaPyRFzstTc2e4VFpCHk1qjEo9g57
         hc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=2+2llm65gY/AnHMvMNM6YHuxvy+tCyy16sq/0xteZU4=;
        b=MUn0foVRScjAoJOA4/pqYhHBLV8IIybB70t2Q9mCwTsVIz2yGjeQwgMYpqK9l1R0Z8
         hC5KlHQjFDlvH0abzr+d8DVhupgbh1rPMnIC6L34nR6gig7Q137OhCcXx2GYS5qKQT2M
         A9KE1VjC8l6HRYNWqU/TnyhWy495cLF08x2T0dYtA2Fsnw7ZW+YlPDoP7HIyOB+asicq
         t+5acOPXJt2N36IoY93vluj9j5cM+enyWAtvOl93XnWiLWmsqE9i6k2C235/ITbCrb46
         JRQCFiyk2xc/p5A5Q5izhWAEK3m1tT27YBhoPwzslSI6diEVWWpU8lMkfXrsXncI58Kj
         pYKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=GL78DO//;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=GL78DO//;
       spf=pass (google.com: domain of maran.wilson@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=maran.wilson@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [RFC PATCH v4 6/7] xen/pvh: Add memory map pointer to
 hvm_start_info struct
To: Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>
Cc: thomas.lendacky@amd.com, andrew.cooper3@citrix.com, roger.pau@citrix.com,
        davem@davemloft.net, hch@infradead.org, rdunlap@infradead.org,
        luto@kernel.org, mchehab@kernel.org, x86@kernel.org,
        linus.walleij@linaro.org, tglx@linutronix.de,
        dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com,
        gregkh@linuxfoundation.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, bp@suse.de,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-7-git-send-email-maran.wilson@oracle.com>
 <81b64427-4d4e-8758-436a-f2b98e3e6829@suse.com>
 <5A97AEC70200007800128C14@prv-mh.provo.novell.com>
From: Maran Wilson <maran.wilson@oracle.com>
Organization: Oracle Corporation
Message-ID: <d803e176-1d6b-4426-f6bd-abfa4a746983@oracle.com>
Date: Thu, 1 Mar 2018 09:19:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5A97AEC70200007800128C14@prv-mh.provo.novell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=881
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803010214
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593671064225719544?=
X-GMAIL-MSGID: =?utf-8?q?1593756700511789008?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/28/2018 11:41 PM, Jan Beulich wrote:
>>>>> Juergen Gross <jgross@suse.com> 03/01/18 8:29 AM >>>
>> On 28/02/18 19:28, Maran Wilson wrote:
>>> The start info structure that is defined as part of the x86/HVM direct boot
>>> ABI and used for starting Xen PVH guests would be more versatile if it also
>>> included a way to pass information about the memory map to the guest. This
>>> would allow KVM guests to share the same entry point.
>>>
>>> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
>> I'm fine with this, but we need this change being accepted by the Xen
>> community first. So an Ack from Jan or Andrew is required as the same
>> change should be done on Xen side.
> And for an ack to be given I continue to demand that a patch be sent against
> the Xen tree. That said, the change looks fine to me now (as indicated before).

Yes, I plan to send that out against the Xen tree shortly.

Thanks,
-Maran

> Jan
>
