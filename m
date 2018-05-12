Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeELScW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 14:32:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34023 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeELScT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 14:32:19 -0400
X-Google-Smtp-Source: AB8JxZoGFD0pvUVdji8qD4J++e8N/5591iqfuEpwJeI2TQu8BACqkdW8/J4z0ShwVjEazvyCKZyOtNPJqIIhH2R+eY8=
MIME-Version: 1.0
In-Reply-To: <20180511195341.034688188@goodmis.org>
References: <20180511194927.190877137@goodmis.org> <20180511195341.034688188@goodmis.org>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Sat, 12 May 2018 20:32:18 +0200
Message-ID: <CAKQ1sVPS_rKYUVRRAU-zHKZqCNBKamBoHdHyhXOV+Ckifm1Jbw@mail.gmail.com>
Subject: Re: [RFC][PATCH 07/10] tracing: Have zero size length in filter logic
 be full string
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>, Joel Fernandes <joelaf@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 9:49 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
[]
>
>  static int regex_match_front(char *str, struct regex *r, int len)
>  {
> -       if (len < r->len)
> +       if (len && len < r->len)
>                 return 0;
>
> -       if (strncmp(str, r->pattern, r->len) == 0)
> -               return 1;
> -       return 0;
> +       return strncmp(str, r->pattern, len) == 0;

strncmp(..., r->len) still?

>  }

Regards,
Yann.
