Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu+ycR5bafWTG3Gkrtgr7KOOrHyKa4WMkrK3/8FNcL/RAzRgJ3YSedZAH6RZVMXFHwsQKMH
ARC-Seal: i=1; a=rsa-sha256; t=1521238230; cv=none;
        d=google.com; s=arc-20160816;
        b=YPMvGSU97odh4SxA9Kmo2tX6HjGqDZ9G/UQ5FegbxqruIIZzpxW21Swiq0umHkPS8a
         58I4vLPl5vR2STH/u07rq/uUYVLS6Goi0Xt1etlljAMB6Q3J/4YSPS0E06rpFRhatRA9
         lOU7ewxB6BlRYPPdtvAA6x1p77N6rqARQZJvtmUrAdzf3vOSw+uahHl5f7mhUR8XoQV0
         wreycv7N+7S0E5bchjwXCzrcPmidTy0qs7aMe3JgQWAhdDRaZAILf0sLHn5hZ9KzXB2R
         x+7yWWCwBKXdEUpNFowdDorwt1RoqJA4yW3gtsYyAjq+Ea9szq6sKK/LmBFZ5pzbTIA0
         05CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=t2Gl5WIon2O9Tgne6fbFKJhpzTHhnfSFs6j6kUnnIIQ=;
        b=TzQZfMNXVP3qnS7i5v8QkNqs/qAatbTT/hkxxlzexOpC5LysOJE9r4Apy/RwUT9SEj
         I0u/OQiK0L/KMBkSvHPKHVHN63W6NnDF5woy3hQLeXczpFWWZ7VEipIAg7RvuKgKPiLC
         Iw2/JT6i40AncoYQOQghdVIng4Z5UblVtWCqSw/UpifmNIwGsMuFow67i26CQRpG/Lfy
         ww3egjjtEbdkS7Yw7I3BnTjZ3Git9Ye6N4UtzdUuWl5k9rFPysSXmzXYcC06eymfTREh
         cgUeiOG6Xs3fJk3BglmpGDUs0hZ5USlO4+l9hGQ/l1M+D15TYVbKe3gB7K4i/tsWcMmN
         XDzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeCPWKR (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:10:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:50519 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbeCPWKQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:10:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25369736"
Subject: Re: [PATCH v12 08/22] selftests/vm: clear the bits in shadow reg when
 a pkey is freed.
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-9-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <a884e9eb-4da6-54af-e09e-acac7ceee397@intel.com>
Date: Fri, 16 Mar 2018 15:10:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-9-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064595048468921?=
X-GMAIL-MSGID: =?utf-8?q?1595133899000849241?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> When a key is freed, the  key  is  no  more  effective.
> Clear the bits corresponding to the pkey in the shadow
> register. Otherwise  it  will carry some spurious bits
> which can trigger false-positive asserts.
...
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index ca54a95..aaf9f09 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -582,6 +582,9 @@ int alloc_pkey(void)
>  int sys_pkey_free(unsigned long pkey)
>  {
>  	int ret = syscall(SYS_pkey_free, pkey);
> +
> +	if (!ret)
> +		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
>  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
>  	return ret;
>  }

Did this cause problems for you in practice?

On x86, sys_pkey_free() does not affect PKRU, so this isn't quite right.
 I'd much rather have the actual tests explicitly clear the PKRU bits
and also in the process clear the shadow bits.
