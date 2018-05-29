Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2038031-1527597117-2-17731006596979553083
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527597117; b=NTXMNirkPs3VvclVQZop/m45zBaZ8lhhJBLMIq+WyVugiPqpKz
    CKVSf4+ogWjUaH7vhJPmRvAB69IVPLQMOJR4wlXHZA0tJY3qF8Jpu6op5CYj1+xL
    E2Es+Vm1JQSYMnl3QipRFaswlaEgbyiIZaOG3+di2eWzc+LVfqHvD4poM4YUwnr1
    VuEzC52Wg6Zdub5oQZs/wxONXDQ6akAZb/hZbWlN8YjlS6hZXsz4Mlgp3KQQy5vZ
    um1rKArT3QoxgPfi0X7TeQXqXOZmFyfyPaaeKvbI76hTDPjlUgK+bAHDjdPuGK+L
    afbxMvbUrfGUKY8Oek2LO91kfUMmrXGRP9/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:in-reply-to
    :references:content-type:mime-version:content-transfer-encoding
    :message-id:sender:list-id; s=fm2; t=1527597117; bh=0gyxxlwzpbUf
    v8ViGnKxLH1E/UK7f4lzfbbd3qI9Sy0=; b=HdxqYFm5y++SPYCNrmppn7Xb7tEs
    O+laswOsa1BFDAKh23GvZheYz6B1H/fqEvXjlY0/OV9JRe6GO7ZW1KQQkdJrdTwx
    GMXh3rn6Y0fYaM8UaGxCuK+FY138l0aKMYh4Qjk7KhaWwgJzj5ugZXtapN+/Duyy
    SnE9OLzNcanKQ3F7C5b6/9aoYcZT0T/uZL1HAj+w2Sb9V4dQO9BWe/XEMFLCygIz
    mb760ki0G3rfcgJ8BIZRgBs5xJ7jV7vhM8N0ZoUCRBnPchPDQu4Kqb6MVnMisSlJ
    ssgW1YR1xMTdzrL9JSzZpCz8XIRGRfNs4uEuvIBPW/ZKagtlwWoBwYMtSw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
    header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.vnet.ibm.com header.result=pass
    header_org.domain=ibm.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none)
      header.from=linux.vnet.ibm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.vnet.ibm.com header.result=pass
      header_org.domain=ibm.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKdD5LI6BxJUvvyWclsVWSWVG1d6TAeHiQy1u6hO/Z+hVXdYbqPQ/1xePKxfynxENizFja/jdOxuG7n07KpWnnti7H3lhYW9Yxaz4lp7PU1QKtglhtk2
    FQBQcicrHd+rwskTD4YTlykt05fcCarXfqOZVp+5V/NhZC1EwDaH/4EUohnesEvFMgyqSgSyZ+qppt0KzItxusYHVl+1DvWfD70s/G2JOJtdUs9ZCH93xEJx
    flL33QPzsHfmA0U6VHRwNw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=bawHruucQdVN6vZjdz8A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933697AbeE2Mby (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 08:31:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933775AbeE2Mbx (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 08:31:53 -0400
Subject: Re: [PATCH] EVM: Fix null dereference on xattr when xattr fails to
 allocate
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
Cc: Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 08:31:32 -0400
In-Reply-To: <20180529090504.6dpdadjyjxo45nu2@mwanda>
References: <20180527225510.25612-1-colin.king@canonical.com>
         <20180529090504.6dpdadjyjxo45nu2@mwanda>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18052912-0020-0000-0000-0000042254D4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052912-0021-0000-0000-000042B7AA45
Message-Id: <1527597092.10176.17.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290143
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dan,

On Tue, 2018-05-29 at 12:05 +0300, Dan Carpenter wrote:
> Not really related to this patch except I was looking at the function:
> 
> security/integrity/evm/evm_secfs.c
>    191          ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
>    192          if (IS_ERR(ab))
>    193                  return PTR_ERR(ab);
>    194  
>    195          xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
>    196          if (!xattr) {
>    197                  err = -ENOMEM;
>    198                  goto out;
>    199          }
>    200  
>    201          xattr->name = memdup_user_nul(buf, count);
>    202          if (IS_ERR(xattr->name)) {
>    203                  err = PTR_ERR(xattr->name);
>    204                  xattr->name = NULL;
>    205                  goto out;
>    206          }
>    207  
>    208          /* Remove any trailing newline */
>    209          len = strlen(xattr->name);
>    210          if (xattr->name[len-1] == '\n')
> 
> strlen() could be zero, leading to a read underflow here.

Thanks!  Could you modify the maximum xattr size check (before this
code snippet) to check for underflow?

Mimi


> 
>    211                  xattr->name[len-1] = '\0';
>    212  
>    213          if (strcmp(xattr->name, ".") == 0) {
>    214                  evm_xattrs_locked = 1;
>    215                  newattrs.ia_mode = S_IFREG | 0440;
>    216                  newattrs.ia_valid = ATTR_MODE;
>    217                  inode = evm_xattrs->d_inode;
>    218                  inode_lock(inode);
>    219                  err = simple_setattr(evm_xattrs, &newattrs);
>    220                  inode_unlock(inode);
>    221                  audit_log_format(ab, "locked");
>    222                  if (!err)
>    223                          err = count;
>    224                  goto out;
>    225          }
> 
> regards,
> dan carpenter
> 

