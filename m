Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756097AbeEAQnA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 12:43:00 -0400
Received: from mail-ua0-f180.google.com ([209.85.217.180]:39545 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754727AbeEAQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 12:42:58 -0400
X-Google-Smtp-Source: AB8JxZo7lRi4fSeI2URY/3jbFltupQCW/jDX2ImbHoUx4fTL7UbPFNgV/YEA3v1doRYK+MJElDlbK5UXwTcVi0B87WY=
MIME-Version: 1.0
In-Reply-To: <20180501161010.GB23157@codeaurora.org>
References: <20180419221635.17849-1-ilina@codeaurora.org> <20180419221635.17849-6-ilina@codeaurora.org>
 <20180425214111.GC243180@google.com> <20180427173943.GD6380@codeaurora.org>
 <20180427184017.GI243180@google.com> <20180427194559.GE6380@codeaurora.org>
 <20180427200605.GJ243180@google.com> <20180427213201.GA23157@codeaurora.org>
 <20180427215449.GA133494@google.com> <CAD=FV=Wan0G_GG29Q-atBbQS+_7nnbqTndE+yyi_G=scOdGMFA@mail.gmail.com>
 <20180501161010.GB23157@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 1 May 2018 09:42:55 -0700
X-Google-Sender-Auth: 9oniv0X0tNXHvhPD_d_s3Cs1Y5s
Message-ID: <CAD=FV=XAPLxFqMvWrvAbpki0AvN_TqKgzBYmZAuomVz-9ieK=Q@mail.gmail.com>
Subject: Re: [PATCH v6 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
To: Lina Iyer <ilina@codeaurora.org>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 1, 2018 at 9:10 AM, Lina Iyer <ilina@codeaurora.org> wrote:
> Yes, this is incorrect in its current form. This is what it should be -
>
> static int find_match(const struct tcs_group *tcs, const struct tcs_cmd
> *cmd,
>                      int len)
> {
>        int i, j;
>
>        /* Check for already cached commands */
>        for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
>                if (tcs->cmd_cache[i] != cmd[0].addr)
>                        continue;
>                for (j = 0; j < len; j++) {
>                        WARN(tcs->cmd_cache[i + j] != cmd[j].addr,
>                             "Message does not match previous sequence.\n");
>                        return -EINVAL;
>                }

If len > 0, won't the above always return -EINVAL?


>                if (j == len - 1)
>                        return i;

Care to explain how you could get here and the test "if (j == len -
1)" could be false?  ;-P

-Doug
