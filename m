Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752038AbeECGRH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 02:17:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:59498 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbeECGRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 02:17:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="36495440"
Subject: Re: [RFC] perf record: dead code perf_event__synthesize_id_index()
To: Jiri Olsa <jolsa@redhat.com>, Stephane Eranian <eranian@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Peter Zijlstra <peterz@infradead.org>,
        "Shishkin, Alexander" <alexander.shishkin@intel.com>
References: <CABPqkBTm+9Wsa21GVXpogWUDNkpRF4eyZOPGa8QJCvdV2Lz2rA@mail.gmail.com>
 <20180502165737.GF11539@krava>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <cd10fb5e-90bc-f190-6553-7b29cd618ef5@intel.com>
Date: Thu, 3 May 2018 09:15:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502165737.GF11539@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/18 19:57, Jiri Olsa wrote:
> On Wed, May 02, 2018 at 04:38:33PM +0000, Stephane Eranian wrote:
>> Hi,
>>
>> It looks like perf_event__synthesize_id_index() is dead code in the current
>> tip
>> tree. I don't see any invocation of the function anywhere in perf.I
>> understand why
>> you'd want to keep the rest of the code related to  PERF_RECORD_ID_INDEX
>> because some perf.data file may have this user-level record type. But the
>> synthesize code is not needed anymore, in my opinion.
>>
>> Shouldn't we remove this code?
> 
> looks like there never was any user of it, probably some
> preparation for follow up that haven't happened yet.. Adrian?

Yes it is for AUX area sampling support, which we have patches for.  Just
waiting on Alex to get the kernel side accepted.
