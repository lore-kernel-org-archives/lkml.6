Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755526AbeEaPqO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:46:14 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40052 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeEaPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:46:10 -0400
X-Google-Smtp-Source: ADUXVKKreM4LjY1cccazSRut9lhhnRww1C8X2PwAFRIuimZpv4XQaBLSRw7Z6ZM8OFlhCPRmntbgmg==
Subject: Re: [PATCH] block: Add block level changes for inline encryption
To: Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Manjunath M Bettegowda <Manjunath.MB@synopsys.com>,
        Prabu Thangamuthu <Prabu.T@synopsys.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
References: <d3624fab-e6fc-f14d-c780-db703c809068@synopsys.com>
 <77544032-b6ff-bc5e-9fec-666e66b2cc70@kernel.dk>
 <BD7FB879CC136E419544C8E2AE7B9C3020BD90@IN01WEMBXA.internal.synopsys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3fc7786c-af85-d047-047f-44d4eded6124@kernel.dk>
Date: Thu, 31 May 2018 09:46:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C3020BD90@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/18 1:47 AM, Ladvine D Almeida wrote:
> On Monday 28 May 2018 04:54 PM, Jens Axboe wrote:
>> On 5/28/18 7:43 AM, Ladvine D Almeida wrote:
>>> This patch introduces new variable under bio structure to
>>> facilitate inline encryption. This variable is used to
>>> associate I/O requests to crypto information.
>> Hard no on this, for two reasons:
>>
>> 1) Any additions to struct bio are scrutinized heavily and
>>    need strong justification.
> 
> Thanks for sharing your feedback on the patch.
> I am providing reference to an earlier article related to inline encryption support below:
> https://lwn.net/Articles/717754/

Took a quick look, and this looks like a classic case of something
that should just be a cloned bio. If you clone, you own the bi_private
field, which is what you need.

-- 
Jens Axboe
