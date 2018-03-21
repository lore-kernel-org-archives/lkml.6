Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1029091-1521672864-2-18349478787200129364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521672863; b=LOrfkva4zuK1awWlsphH5yAZ+p4dhvc4K8ff3Bpn7nPjNKZ
    eQtDW11n8FGd8A/aly9tXDcSY8mbLEoe2FP4BLdz979THzh6JgppZPK7cupJrrQg
    MdMCKkHkLpuH09hkAebN4deGXuQhDcM9FTwfc2cV0G5P0tPIswJ/jvUyNYOw2yrA
    ah8v3PnJCRV4IgmFShbVLROKBgNF6JiwC1+uKotQnlkqLIQXtPVeILdyl8Hjbvfb
    ZaffVZU2GQwtrsNuGKQlP/qHsYK1H1Z/EwtpjkZz6rzzw2rHoTEyhpvqOwrhlcf8
    kQgi19/WrXrVXSDK26EGhiG6KNkOeSpdMrjaS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521672863; bh=YaKSMGYDYuxyU2jYMvURRgioGNRbmGTcyAQu15W+Nxc=; b=h
    HQzyEtPeKi5f1zOhuR9vlyoQKS3uY9Dlf5dKyUE1/EPa9X2d5hHCYr/oNLFbohas
    dSLoMTLEbGpge/Zge2JQCmWQ1IMZ/qu1ev1xxiqClLT+6JOuzlEn5ppx9ETZwZQn
    PrtobelAFB8lFf6tvu2Bzr4pSp96L85M0EIUNp0MfTBYNVeb+VI4bvR/ao4hPXUl
    x0ENev7Lv4df2Bn9FaWJCypBeGkutz1Tge39Pb5IDs2ma7a+burTh2+ZtOCW3XnN
    Skwg+PXeguuipZnwOF3iH7cGw58BooUGj9LJFvF4vn5tbBVtEuWcRQgzw1Z3E+Nx
    ckH2Mr05r/cPM3j2zBzhg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ia0bwR1b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=ia0bwR1b x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeCUWyU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 18:54:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55540 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753715AbeCUWyT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 18:54:19 -0400
Subject: Re: [PATCH v2] shm: add split function to shm_vm_ops
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, stable@vger.kernel.org
References: <0d24f817-303a-7b4d-4603-b2d14e4b391a@oracle.com>
 <20180321161314.7711-1-mike.kravetz@oracle.com>
 <20180321135618.f3d4a0c30d9f413ce4092ddf@linux-foundation.org>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <051fa302-f4c2-cc90-7a12-eaedfa806e73@oracle.com>
Date: Wed, 21 Mar 2018 15:53:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180321135618.f3d4a0c30d9f413ce4092ddf@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21/2018 01:56 PM, Andrew Morton wrote:
> On Wed, 21 Mar 2018 09:13:14 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>  
>> +static int shm_split(struct vm_area_struct *vma, unsigned long addr)
>> +{
>> +	struct file *file = vma->vm_file;
>> +	struct shm_file_data *sfd = shm_file_data(file);
>> +
>> +	if (sfd->vm_ops && sfd->vm_ops->split)
>> +		return sfd->vm_ops->split(vma, addr);
> 
> This will be the only site which tests for NULL shm_file_data.vm_ops. 
> It's a can't-happen, methinks.

You are correct, thanks for catching this.

> 
> I think I'll leave it as it is for now and will queue up a non-urgent
> patch:
> 
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: ipc/shm.c: shm_split(): remove unneeded test for NULL shm_file_data.vm_ops
> 
> This was added by the recent "ipc/shm.c: add split function to
> shm_vm_ops", but it is not necessary.
> 
> Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Manfred Spraul <manfred@colorfullife.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Looks good, FWIW
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz

> ---
> 
>  ipc/shm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN ipc/shm.c~ipc-shmc-shm_split-remove-unneeded-test-for-null-shm_file_datavm_ops ipc/shm.c
> --- a/ipc/shm.c~ipc-shmc-shm_split-remove-unneeded-test-for-null-shm_file_datavm_ops
> +++ a/ipc/shm.c
> @@ -391,7 +391,7 @@ static int shm_split(struct vm_area_stru
>  	struct file *file = vma->vm_file;
>  	struct shm_file_data *sfd = shm_file_data(file);
>  
> -	if (sfd->vm_ops && sfd->vm_ops->split)
> +	if (sfd->vm_ops->split)
>  		return sfd->vm_ops->split(vma, addr);
>  
>  	return 0;
> _
> 
