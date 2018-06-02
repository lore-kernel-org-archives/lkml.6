Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeFBUDG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 16:03:06 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:54003 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752051AbeFBUDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 16:03:05 -0400
X-Google-Smtp-Source: ADUXVKKVzVt2bxBBbuAnmeTueSx+Sd+szaD5/osdpHmUXq/p7QXxpN+2xIMOfEJFNC/oy8nIEvYfYQ==
Subject: Re: [PATCH] dm-crypt: fix warning in shutdown path
To: Kent Overstreet <kent.overstreet@gmail.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, snitzer@redhat.com
References: <20180602174504.1847-1-kent.overstreet@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <974665e7-fa4a-230b-99d8-e773489cc6bc@kernel.dk>
Date: Sat, 2 Jun 2018 14:03:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180602174504.1847-1-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/18 11:45 AM, Kent Overstreet wrote:
> The counter for the number of allocated pages includes pages in the
> mempool's reserve, so checking that the number of allocated pages is 0
> needs to happen after we exit the mempool.

Looks good, but needs a fixes line. I'll add one.

-- 
Jens Axboe
