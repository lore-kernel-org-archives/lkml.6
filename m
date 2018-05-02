Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeEBQit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:38:49 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33543 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeEBQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:38:46 -0400
X-Google-Smtp-Source: AB8JxZp8GbPfZz2Be7GSYUDWg+IgPQfLC9SJuKzzxO17QQLSHNto/6iy74lLFdUGTAYQSEjBjuz3xV3Paery1zYNPn0=
MIME-Version: 1.0
From: Stephane Eranian <eranian@google.com>
Date: Wed, 02 May 2018 16:38:33 +0000
Message-ID: <CABPqkBTm+9Wsa21GVXpogWUDNkpRF4eyZOPGa8QJCvdV2Lz2rA@mail.gmail.com>
Subject: [RFC] perf record: dead code perf_event__synthesize_id_index()
To: LKML <linux-kernel@vger.kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, mingo@elte.hu,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like perf_event__synthesize_id_index() is dead code in the current
tip
tree. I don't see any invocation of the function anywhere in perf.I
understand why
you'd want to keep the rest of the code related to  PERF_RECORD_ID_INDEX
because some perf.data file may have this user-level record type. But the
synthesize code is not needed anymore, in my opinion.

Shouldn't we remove this code?
