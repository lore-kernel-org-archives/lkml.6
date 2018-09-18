Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD5CECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0042206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0042206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeIRPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:25:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:35702 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbeIRPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:25:20 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2Ch4-0007ob-FX; Tue, 18 Sep 2018 11:53:18 +0200
Received: from [178.197.249.15] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1g2Ch4-000TYk-8w; Tue, 18 Sep 2018 11:53:18 +0200
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
To:     Vakul Garg <vakul.garg@nxp.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        davejwatson@fb.com, doronrk@fb.com
References: <20180918101107.74d8689a@canb.auug.org.au>
 <93982e9d-dc78-6423-bb9b-c5773d98e244@iogearbox.net>
 <DB7PR04MB42522B223D4E04F5DA519A8B8B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
 <236589cd-b55d-1ceb-f236-36f9135f794e@iogearbox.net>
 <DB7PR04MB4252D31B8E79B789CC507D248B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5959dad0-dd02-1c3d-2487-13a69f8c507b@iogearbox.net>
Date:   Tue, 18 Sep 2018 11:53:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <DB7PR04MB4252D31B8E79B789CC507D248B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24951/Tue Sep 18 10:16:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18/2018 11:32 AM, Vakul Garg wrote:
>> -----Original Message-----
>> From: Daniel Borkmann <daniel@iogearbox.net>
>> Sent: Tuesday, September 18, 2018 2:57 PM
>> To: Vakul Garg <vakul.garg@nxp.com>; Stephen Rothwell
>> <sfr@canb.auug.org.au>; David Miller <davem@davemloft.net>;
>> Networking <netdev@vger.kernel.org>
>> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
>> Mailing List <linux-kernel@vger.kernel.org>
>> Subject: Re: linux-next: manual merge of the net-next tree with the net tree
>>
>> On 09/18/2018 11:10 AM, Vakul Garg wrote:
>>>> -----Original Message-----
>>>> From: Daniel Borkmann <daniel@iogearbox.net>
>>>> Sent: Tuesday, September 18, 2018 2:14 PM
>>>> To: Stephen Rothwell <sfr@canb.auug.org.au>; David Miller
>>>> <davem@davemloft.net>; Networking <netdev@vger.kernel.org>
>>>> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux
>>>> Kernel Mailing List <linux-kernel@vger.kernel.org>; Vakul Garg
>>>> <vakul.garg@nxp.com>
>>>> Subject: Re: linux-next: manual merge of the net-next tree with the
>>>> net tree
>>>>
>>>> On 09/18/2018 02:11 AM, Stephen Rothwell wrote:
>>>>> Hi all,
>>>>>
>>>>> Today's linux-next merge of the net-next tree got a conflict in:
>>>>>
>>>>>   tools/testing/selftests/net/tls.c
>>>>>
>>>>> between commit:
>>>>>
>>>>>   50c6b58a814d ("tls: fix currently broken MSG_PEEK behavior")
>>>>>
>>>>> from the net tree and commit:
>>>>>
>>>>>   c2ad647c6442 ("selftests/tls: Add test for recv(PEEK) spanning
>>>>> across multiple records")
>>>>>
>>>>> from the net-next tree.
>>>>>
>>>>> I fixed it up (see below) and can carry the fix as necessary. This
>>>>> is now fixed as far as linux-next is concerned, but any non trivial
>>>>> conflicts should be mentioned to your upstream maintainer when your
>>>>> tree is submitted for merging.  You may also want to consider
>>>>> cooperating with the maintainer of the conflicting tree to minimise
>>>>> any particularly complex conflicts.
>>>>
>>>> The test from 50c6b58a814d supersedes the one from c2ad647c6442 so
>>>> the recv_peek_large_buf_mult_recs could be removed; latter was also
>>>> not working correctly due to this bug.
>>>
>>> Why remove recv_peek_large_buf_mult_recs if its correct?
>>> Why not the newly added one which achieves the same thing?
>>
>> Hmm, not quite, on net-next kernel, the recv_peek_large_buf_mult_recs fails
>> every time I invoke the tls test suite:
>>
>> # ./tls
>> [==========] Running 28 tests from 2 test cases.
>> [ RUN      ] tls.sendfile
>> [       OK ] tls.sendfile
>> [ RUN      ] tls.send_then_sendfile
>> [       OK ] tls.send_then_sendfile
>> [ RUN      ] tls.recv_max
>> [       OK ] tls.recv_max
>> [ RUN      ] tls.recv_small
>> [       OK ] tls.recv_small
>> [ RUN      ] tls.msg_more
>> [       OK ] tls.msg_more
>> [ RUN      ] tls.sendmsg_single
>> [       OK ] tls.sendmsg_single
>> [ RUN      ] tls.sendmsg_large
>> [       OK ] tls.sendmsg_large
>> [ RUN      ] tls.sendmsg_multiple
>> [       OK ] tls.sendmsg_multiple
>> [ RUN      ] tls.sendmsg_multiple_stress
>> [       OK ] tls.sendmsg_multiple_stress
>> [ RUN      ] tls.splice_from_pipe
>> [       OK ] tls.splice_from_pipe
>> [ RUN      ] tls.splice_from_pipe2
>> [       OK ] tls.splice_from_pipe2
>> [ RUN      ] tls.send_and_splice
>> [       OK ] tls.send_and_splice
>> [ RUN      ] tls.splice_to_pipe
>> [       OK ] tls.splice_to_pipe
>> [ RUN      ] tls.recvmsg_single
>> [       OK ] tls.recvmsg_single
>> [ RUN      ] tls.recvmsg_single_max
>> [       OK ] tls.recvmsg_single_max
>> [ RUN      ] tls.recvmsg_multiple
>> [       OK ] tls.recvmsg_multiple
>> [ RUN      ] tls.single_send_multiple_recv
>> [       OK ] tls.single_send_multiple_recv
>> [ RUN      ] tls.multiple_send_single_recv
>> [       OK ] tls.multiple_send_single_recv
>> [ RUN      ] tls.recv_partial
>> [       OK ] tls.recv_partial
>> [ RUN      ] tls.recv_nonblock
>> [       OK ] tls.recv_nonblock
>> [ RUN      ] tls.recv_peek
>> [       OK ] tls.recv_peek
>> [ RUN      ] tls.recv_peek_multiple
>> [       OK ] tls.recv_peek_multiple
>> [ RUN      ] tls.recv_peek_large_buf_mult_recs
>> tls.c:524:tls.recv_peek_large_buf_mult_recs:Expected memcmp(test_str,
>> buf, len) (18446744073709551595) == 0 (0)
>> tls.recv_peek_large_buf_mult_recs: Test failed at step #8
>> [     FAIL ] tls.recv_peek_large_buf_mult_recs
>> [ RUN      ] tls.pollin
>> [       OK ] tls.pollin
>> [ RUN      ] tls.poll_wait
>> [       OK ] tls.poll_wait
>> [ RUN      ] tls.blocking
>> [       OK ] tls.blocking
>> [ RUN      ] tls.nonblocking
>> [       OK ] tls.nonblocking
>> [ RUN      ] tls.control_msg
>> [       OK ] tls.control_msg
>> [==========] 27 / 28 tests passed.
>> [  FAILED  ]
>>
>> Here's what the recvfrom() with MSG_PEEK sees:
>>
>> [pid  2602] socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 3 [pid  2602]
>> socket(AF_INET, SOCK_STREAM, IPPROTO_IP) = 4 [pid  2602] bind(4,
>> {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("0.0.0.0")}, 16) =
>> 0
>> [pid  2602] listen(4, 10)               = 0
>> [pid  2602] getsockname(4, {sa_family=AF_INET, sin_port=htons(41483),
>> sin_addr=inet_addr("0.0.0.0")}, [16]) = 0 [pid  2602] connect(3,
>> {sa_family=AF_INET, sin_port=htons(41483), sin_addr=inet_addr("0.0.0.0")},
>> 16) = 0 [pid  2602] setsockopt(3, SOL_TCP, 0x1f /* TCP_??? */, [7564404], 4)
>> = 0 [pid  2602] setsockopt(3, 0x11a /* SOL_?? */, 1,
>> "\3\0033\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
>> 40) = 0 [pid  2602] accept(4, {sa_family=AF_INET, sin_port=htons(46290),
>> sin_addr=inet_addr("127.0.0.1")}, [16]) = 5 [pid  2602] setsockopt(5,
>> SOL_TCP, 0x1f /* TCP_??? */, [7564404], 4) = 0 [pid  2602] setsockopt(5,
>> 0x11a /* SOL_?? */, 2,
>> "\3\0033\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
>> 40) = 0
>> [pid  2602] close(4)                    = 0
>> [pid  2602] sendto(3, "test_read_peek", 14, 0, NULL, 0) = 14 [pid  2602]
>> sendto(3, "_mult_recs\0", 11, 0, NULL, 0) = 11 [pid  2602] recvfrom(5,
>> "test_read_peektest_read_peektest"..., 64, MSG_PEEK, NULL, NULL) = 64
>> [pid  2602] write(2, "tls.c:526:tls.recv_peek_large_bu"...,
>> 112tls.c:526:tls.recv_peek_large_buf_mult_recs:Expected memcmp(test_str,
>> buf, len) (18446744073709551595) == 0 (0)
>> ) = 112
>> [pid  2602] close(3)                    = 0
>> [pid  2602] close(5)                    = 0
>> [pid  2602] exit_group(8)               = ?
>>
>> Reason for the "test_read_peektest_read_peektest[...]" is because
>> MSG_PEEK cannot call tls_sw_advance_skb(), since the skb is sitting there
>> that needs to be consumed for non-MSG_PEEK case, and only then we can
>> advance it.
> 
> I general, my plan was to modify the tls_sw_recvmsg() to trigger as many 
> decryption as possible as required by requested user space PEEK size.
> This would have required creating a pending list of decrypted records in tls_tx context.

Right, had been thinking the same though for a fix in -net it would have been
way too intrusive, hence the 50c6b58a814d ("tls: fix currently broken MSG_PEEK
behavior") to avoid looping the same record which is clearly a bug. Wondering
if DaveW's original rationale was to avoid accumulating too many records in the
kernel since we would need to unpause strparser and keep processing the deeper
we peek.

>> Could you elaborate on where you ever had this test succeeding? With nxp
>> accelerator?
>  
> I never had this test succeeding. I pointed the problem to Dave Watson sometime
> back (found during code reading). 
> 
> To make sure that this bug does not slip out, I simply submitted a test case to keep
> reminding ourselves that we need to fix it sometime.

Ok, I think usually tests assert current kernel behavior to make sure any changes
coming in don't accidentally break expectations from applications as opposed to
future tests that still need fixing, but I guess I'm fine either way how to resolve
the conflict; leaving it up to DaveM. Thanks for clarifying!

Cheers,
Daniel
