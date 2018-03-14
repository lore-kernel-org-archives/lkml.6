Return-Path: <kernel-hardening-return-12611-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvwrRh6Nthatgrgi14wBcgfpSNUaxXRsph16nWPOmyAPZH1LfEQn78FMyBu2uHuKnR66/uv
ARC-Seal: i=1; a=rsa-sha256; t=1521049267; cv=none;
        d=google.com; s=arc-20160816;
        b=reXCU36z+kd4FZecZqhVIh8+RsDzqjV/j2dq/RdtODBJXYWfjddmdpxOfnj/qosxU6
         f9G25GL4MfKPo0b7nTw/oGxQjjchsRg6JkWaUJCKa16Q/oxJtZm8sfgR/1Gyt7re+Q74
         D4ipmOTtFiQtY7uy7LJijVnLySSK/FinMO7nalTtFjIKXd9JTIaSp+wC22u1/Rnr2pcZ
         Rlpn1SgXx7PTYt4Q9+c8J9RADF1rSLGK+b/Fapl+TjPX8r8HAuaxJG5B7MGED79oyJnu
         WNx4/nttSHkQOvvi59uz7yjzNgms6UIA/FW0eKDPjxXfRVzQ1nn5wSwDAyymMOVpeEO/
         n6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=nItulkEL7xNE/nFSGik98rnOYgScM80tRI4ffUv5Au4=;
        b=NA3ryDk16aBn+9pJO+9eNvoNlt0VfrbsevpmndQRociwT0ohoEBEQpeqbwVRRkFSHJ
         QsEDC8CKmWIwkt54DjBYIm/peKPDh7W9UfvDHJNqt+EZOH38kb6T2CkoWqRBpf8SFEOm
         4hqlkG3Uo2GVrFIGrIoCpWmYbEmB016N+enl2apCDKuH+h8KvE/q0W1aEz1BUasrRYsZ
         ipjE5V9F12jfGRIR7q69aDeVqbT8mkk8H7C472U3WVZAB14E+EA3sHt/08IBwIV+cMVk
         ZB8AmR5g+W1r9L6iDrIgqIuRYcxBcFiv5sjwAzSUrIV4Ao06QLLOQE8cpiY+7QxCCeYH
         44hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ak8t30mF;
       spf=pass (google.com: domain of kernel-hardening-return-12611-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12611-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ak8t30mF;
       spf=pass (google.com: domain of kernel-hardening-return-12611-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12611-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 5/8] Protectable Memory
To: Igor Stoppa <igor.stoppa@huawei.com>, Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, rppt@linux.vnet.ibm.com, keescook@chromium.org,
 mhocko@kernel.org, labbott@redhat.com,
 linux-security-module@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-6-igor.stoppa@huawei.com>
 <20180314121547.GE29631@bombadil.infradead.org>
 <eb9bc944-b1de-48d9-652f-9f898ec4fcec@huawei.com>
From: J Freyensee <why2jjj.linux@gmail.com>
Message-ID: <c528d92e-644b-ba2c-4494-b82cc35a26b5@gmail.com>
Date: Wed, 14 Mar 2018 10:40:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <eb9bc944-b1de-48d9-652f-9f898ec4fcec@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860899667726963?=
X-GMAIL-MSGID: =?utf-8?q?1594935756864155050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



>>> +struct pmalloc_data {
>>> +	struct gen_pool *pool;  /* Link back to the associated pool. */
>>> +	bool protected;     /* Status of the pool: RO or RW. */
>>> +	struct kobj_attribute attr_protected; /* Sysfs attribute. */
>>> +	struct kobj_attribute attr_avail;     /* Sysfs attribute. */
>>> +	struct kobj_attribute attr_size;      /* Sysfs attribute. */
>>> +	struct kobj_attribute attr_chunks;    /* Sysfs attribute. */
>>> +	struct kobject *pool_kobject;
>>> +	struct list_head node; /* list of pools */
>>> +};
>> sysfs attributes aren't free, you know.  I appreciate you want something
>> to help debug / analyse, but having one file for the whole subsystem or
>> at least one per pool would be a better idea.
> Which means that it should not be normal sysfs, but rather debugfs, if I
> understand correctly, since in sysfs 1 value -> 1 file.

Yes, that is a good idea, to use debugfs so you still have a means to 
debug/analyze but can be also turned off for normal system execution.  
Sorry I didn't think about that earlier to save a revision, that's one 
of my favorite things I like to use for diagnosis.

Jay
