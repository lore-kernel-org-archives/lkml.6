Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELunJpZpCFEsYrylbewxtlBB6m4ufiKk2a3DPrbltfD2tV2I4Kw2xLIewJyIhKQhcQqUjQPa
ARC-Seal: i=1; a=rsa-sha256; t=1521238111; cv=none;
        d=google.com; s=arc-20160816;
        b=IYHtVWJYAC8oeO88RfHjwj3iT/cHEeJzNKQN8c6H8JfVM4Rhg5ZmJHixatXny8qmDm
         W/jcWSAo3pUM7DAamrSeHrT1CQd0hUZl5zueucBptdMnLh6DAq8mmFkcl/1o9SwFrggw
         1wvwUg2CoPfazXyrWIzIeKMKIQA1F6XRt2fy2LGiE3qabTl7/DqclnW/j9XSmhCH3hqy
         xnQrQOqg1SeQH38K5ZbDSgcnEunmBJsFLbxu/gXVwTCDkTeXwZ/mgvunDqcdBaDriYRv
         4t7e1c1nEkjuuz8psrPS4/43D2LlA04nK36lbFx6rUlpf2JGg0kRZFa0wYPZHpPDNYVU
         FXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=tohA3jLJASPqqF3rUnDWvLue0HQVJqITqkkoh7kUl/c=;
        b=S3YTS+dswAtkRrEvOmtt+N2SbfbPaJwz3X+d3HQKgpig9EenjM6Rv+GmDeO3N8y/SC
         YgouYnnX4pLSCwtryhn4elz1IU0Ab2QTduW+ynsppAvZnxMBjSYBkB83z9VJYB8koP/t
         xfXfEER1zUhUVZaygkEqdhxy+bI/KMO9qiVA0PA6kyLWfPnFro7CR5uIdI+jE7iOklZc
         gTidNkw1vNgk/PVN+NtdXaiMn03SycDfND0J7283LrSG7pCon3arLXJNgygiWesYU2Fl
         wQpxUmP0NsGlxmwyqeHYPBbqCyfEe1YhWovVrqedjZGdsRfmNCBqJXGlZhgn3UR3hZYS
         6mUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751448AbeCPWIb (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:08:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:37259 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeCPWI3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:08:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25369515"
Subject: Re: [PATCH v12 07/22] selftests/vm: fixed bugs in
 pkey_disable_clear()
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
Date: Fri, 16 Mar 2018 15:08:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064680200522222?=
X-GMAIL-MSGID: =?utf-8?q?1595133774130032705?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -461,7 +461,7 @@ void pkey_disable_clear(int pkey, int flags)
>  			pkey, pkey, pkey_rights);
>  	pkey_assert(pkey_rights >= 0);
>  
> -	pkey_rights |= flags;
> +	pkey_rights &= ~flags;
>  
>  	ret = pkey_set(pkey, pkey_rights, 0);
>  	/* pkey_reg and flags have the same format */
> @@ -475,7 +475,7 @@ void pkey_disable_clear(int pkey, int flags)
>  	dprintf1("%s(%d) pkey_reg: 0x%016lx\n", __func__,
>  			pkey, rdpkey_reg());
>  	if (flags)
> -		assert(rdpkey_reg() > orig_pkey_reg);
> +		assert(rdpkey_reg() < orig_pkey_reg);
>  }
>  
>  void pkey_write_allow(int pkey)

This seems so horribly wrong that I wonder how it worked in the first
place.  Any idea?
