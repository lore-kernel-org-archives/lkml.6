Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7190CC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E3C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sch7T17C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E3C20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeLAGLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 01:11:46 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58962 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeLAGLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 01:11:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAUIwe4t011951;
        Fri, 30 Nov 2018 19:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=PxwZbLjKgQoXunc74PUvQscm47Sj4mPW9TZmUlQzteU=;
 b=Sch7T17Ci0sOQCQiW0m5jg99oAe7Tv1/RzF2rnuoGMKmc5Etf+R98+3Q19pnnoy0VEiT
 GpqQ1w59hKMOiyfZKHEhhZq39OaURll5s6UcSXAZGx6iHGdnjlkGcr7dv1cTjwjp+SLe
 Wz3stMaB2ZleeCJBDxHYdYBxS6XxEgufrjdD5OTCA3/QND57ygXOObiL/nM5uRUsjSVL
 36jguYBqso/cFMBwxIFS7EJAUh4am3HgwpM0ckkmPNXvA3lbDuMuvX3ZLmdiS0Q5HlN0
 jHQIcrUeBq8l9d9dwl8GoQStzWqBx83AfBtlvo2ZyXPunxTi1TW1IkrlPTwBvK83Wbzt dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nxxkqywk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 19:01:12 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAUJ1BwI007307
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Nov 2018 19:01:11 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAUJ17Is016204;
        Fri, 30 Nov 2018 19:01:08 GMT
Received: from [10.154.136.200] (/10.154.136.200)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Nov 2018 11:01:07 -0800
Subject: Re: [PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, gedwards@ddn.com,
        joe@perches.com, lenaic@lhuard.fr, liang.z.li@intel.com,
        mhocko@kernel.org, mhocko@suse.com, stefanha@redhat.com,
        wei.w.wang@intel.com
References: <20181101171938-mutt-send-email-mst@kernel.org>
 <CAGXu5jJ0HgV2qN=wohEgro6ixqXHOHBTsvS5a9Dcpz8gxVo3bA@mail.gmail.com>
 <CAHk-=wicvws38JqzVF6oNEZ0jGzP6RecR6yAGtyzX3AkoJ321g@mail.gmail.com>
 <20181130084227-mutt-send-email-mst@kernel.org>
From:   Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Message-ID: <e5eb0188-61fa-7556-4c36-68a618ba39bf@oracle.com>
Date:   Fri, 30 Nov 2018 11:01:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181130084227-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus: Avast (VPS 181130-2, 11/30/2018), Outbound message
X-Antivirus-Status: Clean
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9093 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=975
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811300161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/2018 5:44 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 01, 2018 at 04:06:19PM -0700, Linus Torvalds wrote:
>> On Thu, Nov 1, 2018 at 4:00 PM Kees Cook <keescook@chromium.org> wrote:
>>> +       memset(&rsp, 0, sizeof(rsp));
>>> +       rsp.response = VIRTIO_SCSI_S_FUNCTION_REJECTED;
>>> +       resp = vq->iov[out].iov_base;
>>> +       ret = __copy_to_user(resp, &rsp, sizeof(rsp));
>>>
>>> Is it actually safe to trust that iov_base has passed an earlier
>>> access_ok() check here? Why not just use copy_to_user() instead?
>> Good point.
>>
>> We really should have removed those double-underscore things ages ago.
>>
>> Also, apart from the address, what about the size? Wouldn't it be
>> better to use copy_to_iter() rather than implement it badly by hand?
>>
>>                 Linus
> Bijan can you respond please?
> Are you going to look into this and convert code to copy_to_iter?
> I don't think we should release Linux like this, so if you don't
> have the time I'd rather revert for now and you can look
> into reposting for the next release.
>
> Thanks,
>

Sure, will do.  Can I send an individual patch for the fix to 
vhost_scsi_send_tmf_reject()?

Thanks.

--bijan
