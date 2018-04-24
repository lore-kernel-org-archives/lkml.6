Return-Path: <kernel-hardening-return-13110-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+N1qO8L4wguW1KpPALhNpHPY5ZygPBH5cf+l982hBwUW4WNGAXEctyFEUuEjomwA5CE2mK
ARC-Seal: i=1; a=rsa-sha256; t=1524580541; cv=none;
        d=google.com; s=arc-20160816;
        b=X/7gYInPveFSOLsq07D7Mb1Hbwn6sI4z3/c73X9BMJZ4NI7LggK53HuvNBBOVGcbaQ
         mhPStFTN+JpF7w2uHPN/Zfcf7h6kcgJJHUkNdwd0JuGFgk74L12gAVseeCN4UN7kHWrG
         tYYuQvHD63KT3lqnKR8vDUUhrlrE66agKgQLEAGS8sK3fivMykOzPyM/3I04xbI6HCM0
         z3ZxuFpfAX3qAKKdvBqWosAkvEccsKJiQAPooPFS4BPQUzCBGv3QPHRtf0CwL/GqYjbn
         m5N88zT5dmV7YVASB7lshtf05p+MSexe4FfvLy2glZXSck+aQ20F401y18CnykHLS0sB
         35VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=/jfdn4bQ8KoX7ieHcxu24iUNnmf2z9Hm3/lYRQQUTKw=;
        b=Pzny9i7Ipcyzp7zfFdqjD3iwqCYI529B1kfpEkDLwgFh1zGxVFFgqU50OvS/9eH4AI
         HxdjFKOPMrq0Nqq5AiBMDWD1X+HIg1zDYbDjJEWXnjHA0VXY8f4LVfuVKz9ycetemnFO
         f9a9NIukziTBehdn1Kv5ZRPxicq4qeyEH/M8huP4uHexKFU7MbJ9rEE3ecbk+1bJihiS
         7zmV5nW99H/9y3WFd8kfCucCP3xEKOi83x8exCuRS8WID5Gv1muA04oCZnOrFNetZrxA
         Q897rqiH2cItBvFmfZhEGGeDfFDOIwHCpcD7C/87/sc4PV7n3/VZhktnfsL2H+FCQCsf
         uZQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g35A5mmP;
       spf=pass (google.com: domain of kernel-hardening-return-13110-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13110-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g35A5mmP;
       spf=pass (google.com: domain of kernel-hardening-return-13110-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13110-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 9/9] Protect SELinux initialized state with pmalloc
To: Stephen Smalley <sds@tycho.nsa.gov>, willy@infradead.org,
 keescook@chromium.org, paul@paul-moore.com, mhocko@kernel.org, corbet@lwn.net
Cc: labbott@redhat.com, david@fromorbit.com, rppt@linux.vnet.ibm.com,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
 Igor Stoppa <igor.stoppa@huawei.com>
References: <20180423125458.5338-1-igor.stoppa@huawei.com>
 <20180423125458.5338-10-igor.stoppa@huawei.com>
 <13ee6991-db48-d484-66a6-90de45fad2df@tycho.nsa.gov>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <34d804c6-8aea-52ee-41b8-139aaf188d80@gmail.com>
Date: Tue, 24 Apr 2018 18:35:18 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <13ee6991-db48-d484-66a6-90de45fad2df@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598541793965902014?=
X-GMAIL-MSGID: =?utf-8?q?1598638566332608663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 24/04/18 16:49, Stephen Smalley wrote:
> On 04/23/2018 08:54 AM, Igor Stoppa wrote:

[...]

>> The patch is probably in need of rework, to make it fit better with the
>> new SELinux internal data structures, however it shows how to deny an
>> easy target to the attacker.
> 
> I know this is just an example, but not sure why you wouldn't just protect the
> entire selinux_state.

Because I have much more to discuss about SELinux, which would involve 
the whole state, the policyDB and the AVC

I will start a separate thread about that. This was merely as simple as 
possible example of the use of the API.

I just wanted to have a feeling about how it would be received :-)

> Note btw that the selinux_state encapsulation is preparatory work
> for selinux namespaces [1], at which point the structure is in fact dynamically allocated
> and there can be multiple instances of it.  That however is work-in-progress, highly experimental,
> and might not ever make it upstream (if we can't resolve the various challenges it poses in a satisfactory
> way).

Yes, I am aware of this and I would like to discuss also in the light of 
the future directions.

I just didn't want to waste too much time on something that you might 
want to change radically in a month :-)

I already was caught once by surprise when ss_initalized disappeared 
just when I had a patch ready for it :-)

--
igor
