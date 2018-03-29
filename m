Return-Path: <mike.kravetz@oracle.com>
X-Google-Smtp-Source: AIpwx4+Rflrg3DNY6HFJDR+Gu6A/pVi89LDr2hA9gEQJEmS35AGHNguJUwom0+V6Hc3FqoFEu/5U
ARC-Seal: i=1; a=rsa-sha256; t=1522284154; cv=none;
        d=google.com; s=arc-20160816;
        b=T5yRD2LMSEJaskEaC4i+vDjs0NviKTb7iTd0CwUNms6DyUQc5l4y5e08yZvACwE3Pc
         SdsSx7jV7frZ3r3G0OX7YNuxHId/mlaEAPiv6YvdjD1Q0algp6nQ3BQ8OUaDeqxLaVry
         aFSJUALBATFKFYuR9Fv5AuOF3LGOPEF6Ty9XMo3w9uhb0vOhjIUBNxKxSs47LRF/EbRT
         80Tf8qaFT2TMmve9lypLgQWQhg3w/ngTdF7xdTPRA3D0vTP6PczEzJ7RsDUwnql5JXma
         xq/g/ox4tBy36LFRKsJBKMiEnLUQ6tAdNfRwUfst5xoNK0AD5lmqksxehfqzdXiOktHX
         gNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :dkim-signature:arc-authentication-results;
        bh=pDL9Z3CF8s1LoaLJVkZAkw8aUV2X29D2e6sPd0Rwycs=;
        b=WQu1OKNE8mpTJCktNy4WLDeBoinX9N4fxxujG3gUNOqtkjpC/kGpaBk40sNrciWSqa
         AuluYDLX41D9wgHSr/KgBP4UMoCVPpWNF7cr+Vb07JLdPdiETnqxcmgE/zfqI8qGdeyH
         t/caKjICMB7lXGvG5Hm11H71sL6iW2zueMMOW3+2hmxX0FP5IwvX5s9aqXEkY8IzIsOR
         +FS/T+23590rUmafl2UIzXEUOwF7hU0Q8OsmEoY0/ucPc1hx/+zLrIrqOeUy7Py3b1ar
         XccoinklULW03Ys+yBh+V5HZgIYAUSrSTM3bWfzFBX8Qd1JAsJXkQ827tNEsUBRsYFd3
         j1kA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sxc21UN4;
       spf=pass (google.com: domain of mike.kravetz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=mike.kravetz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=sxc21UN4;
       spf=pass (google.com: domain of mike.kravetz@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=mike.kravetz@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 4.15 000/105] 4.15.14-stable review
From: Mike Kravetz <mike.kravetz@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180327162757.813009222@linuxfoundation.org>
 <20180328184423.44nhfdfy26l37b5p@xps>
 <12e0d7ea-4d62-41bf-40fa-e6005460c9b6@oracle.com>
Message-ID: <da7ae092-a74c-12d3-e60c-33f54142c465@oracle.com>
Date: Wed, 28 Mar 2018 17:42:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <12e0d7ea-4d62-41bf-40fa-e6005460c9b6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803280244
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596109687126201688?=
X-GMAIL-MSGID: =?utf-8?q?1596230629835256222?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/28/2018 12:06 PM, Mike Kravetz wrote:
> On 03/28/2018 11:44 AM, Dan Rue wrote:
>> On Tue, Mar 27, 2018 at 06:26:40PM +0200, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.15.14 release.
>>> There are 105 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu Mar 29 16:27:29 UTC 2018.
>>> Anything received after that time might be too late.
>>
>> Results from Linaro’s test farm.
>> No regressions on arm64 and x86_64.
>>
>> There is a regression on arm32 in libhugetlbfs/truncate_above_4GB-2M-32
>> that also exists in 4.14 and mainline. We'll investigate the root cause
>> and report upstream in mainline. I suspect the cause is "hugetlbfs:
>> check for pgoff value overflow", but have not verified yet.
> 
> I'll also take a look as this was a patch I introduced.  


I do not have an arm32 system to test, but am fairly confident the commit
63489f8e8211 (hugetlbfs: check for pgoff value overflow) introduced this
regression.  A new mask was added to check PGOFF for overflow of a lofft.

/*
 * Mask used when checking the page offset value passed in via system
 * calls.  This value will be converted to a loff_t which is signed.
 * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
 * value.  The extra bit (- 1 in the shift value) is to take the sign
 * bit into account.
 */
#define PGOFF_LOFFT_MAX \
	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))

This mask incorrectly used BITS_PER_LONG as the size of a loff_t.  This is
true on 64 bit, but not 32 bit systems.  As a result, mmap of hugetlbfs file
offsets near 4GB will fail.  I suspect the mmap64 call in the test
libhugetlbfs/truncate_above_4GB was the source of the failure.

Can you try the following on arm32?  I will try to set up a 32 bit
x86 system to test as well.  But, it may take me a bit of time.

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b9a254dcc0e7..8450a1d75dfa 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -116,7 +116,8 @@ static void huge_pagevec_release(struct pagevec *pvec)
  * bit into account.
  */
 #define PGOFF_LOFFT_MAX \
-	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
+	(((1UL << (PAGE_SHIFT + 1)) - 1) << \
+	 ((sizeof(loff_t) * BITS_PER_BYTE) - (PAGE_SHIFT + 1)))
 
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
@@ -138,21 +139,32 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
-	 * overflow a (l)off_t when converted to byte offset.
+	 * overflow a loff_t when converted to byte offset.
 	 */
-	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+	if ((loff_t)vma->vm_pgoff & (loff_t)PGOFF_LOFFT_MAX)
 		return -EINVAL;
 
-	/* must be huge page aligned */
+	/* vm_pgoff must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
+	/*
+	 * Compute file offset of the end of this mapping
+	 */
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	/* check for overflow */
+
+	/* Check to ensure this did not overflow loff_t */
 	if (len < vma_len)
 		return -EINVAL;
 
+	/*
+	 * On 32 bit systems, this check is necessary to ensure the last page
+	 * of mapping can be represented as a signed long huge page index.
+	 */
+	if ((len >> huge_page_shift(h)) > LONG_MAX)
+		return -EINVAL;
+
 	inode_lock(inode);
 	file_accessed(file);
 
-- 
Mike Kravetz
