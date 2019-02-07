Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A55C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEDB20863
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfBGPl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:41:59 -0500
Received: from p3plsmtpa11-04.prod.phx3.secureserver.net ([68.178.252.105]:47295
        "EHLO p3plsmtpa11-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbfBGPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:41:58 -0500
Received: from [192.168.0.55] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id rloKgn9rxZBM2rloKgnqGf; Thu, 07 Feb 2019 08:41:58 -0700
Subject: Re: [LSF/MM TOPIC] Discuss least bad options for resolving
 longterm-GUP usage by RDMA
To:     Doug Ledford <dledford@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dave Chinner <david@fromorbit.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-rdma <linux-rdma@vger.kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20190205175059.GB21617@iweiny-DESK2.sc.intel.com>
 <20190206095000.GA12006@quack2.suse.cz> <20190206173114.GB12227@ziepe.ca>
 <20190206175233.GN21860@bombadil.infradead.org>
 <47820c4d696aee41225854071ec73373a273fd4a.camel@redhat.com>
 <01000168c43d594c-7979fcf8-b9c1-4bda-b29a-500efe001d66-000000@email.amazonses.com>
 <20190206210356.GZ6173@dastard> <20190206220828.GJ12227@ziepe.ca>
 <0c868bc615a60c44d618fb0183fcbe0c418c7c83.camel@redhat.com>
 <20190207035258.GD6173@dastard> <20190207052310.GA22726@ziepe.ca>
 <CC414509-F046-49E3-9D0C-F66FD488AC64@oracle.com>
 <6b260348-966a-bc95-162b-44ae8265cf03@talpey.com>
 <f000f699219a8f636dccfbe1fde3e17acdc674a4.camel@redhat.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <ea175620-3dc2-c7f0-1590-02080216edf8@talpey.com>
Date:   Thu, 7 Feb 2019 10:41:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <f000f699219a8f636dccfbe1fde3e17acdc674a4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAF0L4q5BF+i2qxDq6hVvHGMzH5m66vAghTMsoCkgYnCEuoe07eEabPDGQlm6rBhVYK4mOVWeWaN7kbjDPuwZW8nockMHBDnB3CIZXqsP97b07ggiqww
 Nv2u9ttTGXvumDNmU0vN4fXpYKLUMOBx4x5rwGMR4lQte/LdVOt55sDnjTM+3rCdpFSnwvZ81RTtpSTdU7it/LCQFPyNSgzaZ1O9KSiIDabXKUN5cL9UpQsU
 JrkRBbkkqkr11pTwg1bZJlV1BTbQZtB3iRPV7GWphJ61sP1VRQOHc7grpvaGhR0ZPS3pEV2AjOur6Nw39jhi6JrS4k0Qb08h1KjxHBFlUfq3fs+W9IOPU8Y0
 nw9zamydxuFzxd+9KpYzH6s/45BGeQTYMDiTYg+TItDHeVawvuPn/rIZX9bs1XFpxJZaOxvfw8vGmVOmDzlQPn3a2CXFf3Zo1MhJVOh7wsdCCqZwTWtWeUqv
 QIZiqwzc8du2ffu+BKmpZbubSDsHiYNcE099rQPsIV9sDcv7Owa1y1Xdt1C02EfEdz+J9suziPFR78Dz0vNDVyM3gbwu4n4hkVBsWqyFdcBu1hD5i6cTMHLc
 E9RVNFQdAITsHGHYTI8ZHwSq3uwDJXPM0GCYCzqLxRIHdJIukv5UdLOZXxXrfzccK2A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2019 10:37 AM, Doug Ledford wrote:
> On Thu, 2019-02-07 at 10:28 -0500, Tom Talpey wrote:
>> On 2/7/2019 10:04 AM, Chuck Lever wrote:
>>>
>>>> On Feb 7, 2019, at 12:23 AM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Thu, Feb 07, 2019 at 02:52:58PM +1100, Dave Chinner wrote:
>>>>
>>>>> Requiring ODP capable hardware and applications that control RDMA
>>>>> access to use file leases and be able to cancel/recall client side
>>>>> delegations (like NFS is already able to do!) seems like a pretty
>>>>
>>>> So, what happens on NFS if the revoke takes too long?
>>>
>>> NFS distinguishes between "recall" and "revoke". Dave used "recall"
>>> here, it means that the server recalls the client's delegation. If
>>> the client doesn't respond, the server revokes the delegation
>>> unilaterally and other users are allowed to proceed.
>>
>> The SMB3 protocol has a similar "lease break" mechanism, btw.
>>
>> SMB3 "push mode" has long-expected to allow DAX mapping of files
>> only when an exclusive lease is held by the requesting client.
>> The server may recall the lease if the DAX mapping needs to change.
>>
>> Once local (MMU) and remote (RDMA) mappings are dropped, the
>> client may re-request that the server reestablish them. No
>> connection or process is terminated, and no data is silently lost.
> 
> Yeah, but you're referring to a situation where the communication agent
> and the filesystem agent are one and the same and they work
> cooperatively to resolve the issue.  With DAX under Linux, the
> filesystem agent and the communication agent are separate, and right
> now, to my knowledge, the filesystem agent doesn't tell the
> communication agent about a broken lease, it want's to be able to do
> things 100% transparently without any work on the communication agent's
> part.  That works for ODP, but not for anything else.  If the filesystem
> notified the communication agent of the need to drop the MMU region and
> rebuild it, the communication agent could communicate that to the remote
> host, and things would work.  But there's no POSIX message for "your
> file is moving on media, redo your mmap".

Indeed, the MMU notifier and the filesystem need to be integrated.

I'm unmoved by the POSIX argument. This stuff didn't happen in 1990.

Tom.
