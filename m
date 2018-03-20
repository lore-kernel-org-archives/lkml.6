Return-Path: <anand.jain@oracle.com>
X-Google-Smtp-Source: AG47ELtmuoPxkMRvRZpLAubut7yE0Ud0dLMmJ/qd9UYPt6nvCjFaQTCulMdKsPdiblE6Db+uaKnC
ARC-Seal: i=1; a=rsa-sha256; t=1521538268; cv=none;
        d=google.com; s=arc-20160816;
        b=b+eCG2kYJOx0MpZGb8sIJSsCxyVsu9/TnBW7mC29XzfyGRXHDampQ8+bvx7rUy5jA+
         clBu6HbcyNAIriXzJkrxK1G3kRgiSq9WXXmVyaORXwGXucX42evlsIz0y0h+bQgL0/bd
         RvM45hrXGJmGvr/7DvhJl9bKnLYAxL1zDqVDX8yJ4DC7gsZRZoPZr6KBxW+uCTfWN4R/
         WH/idq6bNgcsNdQQ6zPlwMc+Xiu66DGzK+ZHFmS2ZqwPY1BWokhBI9wiAGWY95fkhnFa
         TpGki2jj96XRiwvzmDHdmI2wYKhfnS2/9fLn0c2Snclpu+A/gDdVg2Sm9Vdh8PcjoCfr
         2Sfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=6wUviDbLe5cFYRILVyCVDRS5JEqjz84FvIgfLUCkYfI=;
        b=Wq3nIad5BSja8V/urieDU/h+4UL+nvVizqlsq2rxi+BrlYO2drsqOOXOaq/d9jK0pL
         QzJegR+FiJ0ISX0rMa6JwJjkqSDHYIEzufAnQdwyEKWWoMVor7Dzake6TU64uSiXYQRJ
         goTUA/tLSjWp0u6YHE+0CYk1FcSdmn1DP5Rb4jcyZH6UFI3Zia+g3VklDYt8mSdVpVWa
         ZcvhEsYdezVPvo+l+vSsjQikAZoXJamVHFj11mxcMDNTtCA3Q4VK2dmM5DmE0/388tEs
         seDXWUFxlSktZNw5VDy69jPB6GU5IV+hpriavBiG30zIWYkuig3/oAMs3+tTPF7a6Kf8
         SWOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=T5cmsPbg;
       spf=pass (google.com: domain of anand.jain@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=anand.jain@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=T5cmsPbg;
       spf=pass (google.com: domain of anand.jain@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=anand.jain@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for
 super_copy
To: dsterba@suse.cz, Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liu Bo <bo.li.liu@oracle.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180307191039.748351103@linuxfoundation.org>
 <20180307191042.810088712@linuxfoundation.org>
 <1521139304@msgid.manchmal.in-ulm.de> <20180316123049.GC25079@kroah.com>
 <1521305582@msgid.manchmal.in-ulm.de> <20180319193221.GP6955@suse.cz>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <b14fedbb-55d1-815c-eaa5-c69b5d785615@oracle.com>
Date: Tue, 20 Mar 2018 17:32:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319193221.GP6955@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200114
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594309090147375870?=
X-GMAIL-MSGID: =?utf-8?q?1595448511897207386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/20/2018 03:32 AM, David Sterba wrote:
> On Sat, Mar 17, 2018 at 06:27:15PM +0100, Christoph Biedl wrote:
>> Greg Kroah-Hartman wrote...
>>
>>> On Thu, Mar 15, 2018 at 07:55:42PM +0100, Christoph Biedl wrote:
>>
>>>>> commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.
>>
>>>> On big-endian systems, this change intruduces severe corruption,
>>>> resulting in complete loss of the data on the used block device.
>>
>>> That sucks.  Can you test Linus's tree to verify the problem is there?
>>> I'll gladly revert this if Linus's tree also gets the revert, I don't
>>> want you to hit this when you upgrade to a newer kernel.
>>
>> Confirmed: The problem is, err ... was in Linus' tree as well. The
>> rather recent commit 8f5fd927c3a7 reverted the change, after that
>> everything is as expected again.
> 
> Thanks for checking.
> 
>> Looking at the original commit, I don't have a clue why things go wrong
>> so horribly
> 
> It's a half endianness conversion. The plain in-memory structures are in
> LE and has to be accessed via the helpers, super block copy and the
> root item.  The commit adds only one half of the conversion, that
> naturally does not exhibit on LE, because the macros are no-op.
> 
> Originally, the items were stored from the on-disk type to on-disk type,
> regardless of the CPU:
> 
>    super->chunk_root = root_item->bytenr;
> 
> The patch should have added conversion of both values, like
> 
>    btrfs_set_super_chunk_root(super, btrfs_root_bytenr(root_item));
> 
> and not
> 
>    btrfs_set_super_chunk_root(super, root_item->bytenr);
> 
> It's not very obvious from the context though, typically there's one
> structure that needs the accessors and is set from a value that's in CPU
> byteorder. I think that the exception to this pattern confused all
> involved developers.
> 
> The root_item members are annotated as __le64 that should be caught by
> sparse/smatch checker in the buggy case, but we don't run the checkers
> every the time.

  Ah! the RC is at the other side of the equation.
  Makes sense to me. Thanks.

>> - otherwise don't be afraid of my data. I took this as a
>> chance to verify my data recovery procedure, with success.
> 
> Should that not be the case, the damaged items in superblock can be
> byteswapped back. That's 6 x u64 at most, I have a tool for that now.
> 
> Thanks again for the report and sorry for the trouble.

  It's entirely my mistake. My apologies for the inconvenience.

Thanks, Anand


> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
