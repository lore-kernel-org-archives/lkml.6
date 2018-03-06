Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933153AbeCFWJA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 17:09:00 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34764 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933042AbeCFWI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 17:08:58 -0500
X-Google-Smtp-Source: AG47ELvphJK3hlTEccO9X7s+/Fz/zgUq7IhofjIxi62+JPUtyA/TchLwFdlbT3A1GjHwWEYdsu0pPQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180306165619.GD4930@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-2-ilina@codeaurora.org>
 <152027534725.108663.13213325833387672227@swboyd.mtv.corp.google.com>
 <20180306162140.GC4930@codeaurora.org> <20180306165619.GD4930@codeaurora.org>
Message-ID: <152037413587.218381.10264640935822620220@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/2] drivers: qcom: add command DB driver
Date: Tue, 06 Mar 2018 14:08:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w26M9490023903

Quoting Lina Iyer (2018-03-06 08:56:19)
> On Tue, Mar 06 2018 at 09:21 -0700, Lina Iyer wrote:
> >On Mon, Mar 05 2018 at 11:42 -0700, Stephen Boyd wrote:
> >>Quoting Lina Iyer (2018-02-26 09:58:01)
> >>>+size_t cmd_db_read_aux_data_len(const char *id)
> >>>+{
> >>>+       int ret;
> >>>+       struct entry_header ent;
> >>>+       struct rsc_hdr rsc_hdr;
> >>>+
> >>>+       ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
> >>
> >>A bunch of code is calling this function. Why not change the user
> >>interface to use an opaque 'resource' cookie that we can 'get' or 'find'
> >>and then use that cookie in the rest of the API to pull out the data
> >>that's desired?
> >>
> >Fair point. Let me find out. I suspect this was done to keep the API
> >similar to other non-Linux interfaces. I am not sure why they all didn't
> >use a handle instead of char *.
> >
> I was reminded that the APIs are generally used once for each resource
> and are used for multiple resources and usually only at init. The handle
> method doesn't buy much in benefits.
> 

Ok. Let's take the wait and see approach then.
