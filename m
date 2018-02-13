Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965017AbeBMNxF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:53:05 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33358 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964832AbeBMNxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:53:04 -0500
X-Google-Smtp-Source: AH8x224x7yPQcwEtodBRzsqT7irLhRYGFmXbuvcRkFmMZiuT9bsVvzHQtTo5201rM6QkhGH0rz9QgA==
Subject: Re: [PATCH 1/1] nvme: implement log page low/high offset and dwords
To: Johannes Thumshirn <jthumshirn@suse.de>, hch@lst.de,
        keith.busch@intel.com
Cc: javier@cnexlabs.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20180213124916.28653-1-mb@lightnvm.io>
 <20180213124916.28653-2-mb@lightnvm.io> <1518529671.3592.9.camel@suse.de>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a3b14909-0f9a-b0b3-876e-eb9722b528d1@lightnvm.io>
Date: Tue, 13 Feb 2018 14:53:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1518529671.3592.9.camel@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/2018 02:47 PM, Johannes Thumshirn wrote:
> On Tue, 2018-02-13 at 13:49 +0100, Matias Bjørling wrote:
>> +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>> +			    u8 log_page, void *log,
>> +			    size_t size, size_t offset)
>> +{
>> +	struct nvme_command c = { };
>> +	unsigned long dwlen = (size / 4) - 1;
> 
> Consulting my long gone maths knowledge suggests the parantheses aren't
> really needed here.
> 

Heh, you're right. However, it does make it a bit more readable? The 
untrained eye would properly mess it up was my thinking for keeping them.
