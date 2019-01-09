Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A259C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6352B206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547039496;
	bh=BuOPjn2mkWoYKJG0rd2vD0oWls+zwm2ux+ALhbhY++Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KwGYxLeOyFmTVeElL3FLHHE5wZyLasb3aMUlaePG2V4yz+baVbBG/FHm41KRsTniA
	 jJ//8ozHlvkNM5m0b2rcWevf6Kfv2sVfd9R2lx6Lg150DwHDb80z/qSQgVmL2gJFN+
	 YatvuozDcsOwcs8Pcd0EofVNza6UA0dGa+1nc2m0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfAINLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:11:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbfAINLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:11:35 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1660520675;
        Wed,  9 Jan 2019 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547039494;
        bh=BuOPjn2mkWoYKJG0rd2vD0oWls+zwm2ux+ALhbhY++Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dgoP6Wumhwcm8EACaoLMtDXBtN8fm5HunT0WlGeDKsWPuK8drG252vG7pYtAPlcnh
         XEQFDIlUNfwFEBCwiJu3AtS1Xfj+rR47DvTbY40KzRtLRgje7yKq9XFAqtJzMTzU1S
         wqtwraA2XKuVuLMp6byOoLRS9CjCtvsv3e0WNl0g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FD7740355; Wed,  9 Jan 2019 10:11:31 -0300 (-03)
Date:   Wed, 9 Jan 2019 10:11:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 16/16] tools include uapi: Sync linux/vhost.h with the
 kernel sources
Message-ID: <20190109131131.GB25192@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
 <20190108195910.17726-17-acme@kernel.org>
 <20190108230822-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108230822-mutt-send-email-mst@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 08, 2019 at 11:10:10PM -0500, Michael S. Tsirkin escreveu:
> On Tue, Jan 08, 2019 at 04:59:10PM -0300, Arnaldo Carvalho de Melo wrote:
> > +++ b/tools/include/uapi/linux/vhost.h
> > @@ -11,94 +11,9 @@
> >   * device configuration.
> >   */

> > +#include <linux/vhost_types.h>
 
> Don't you then also need to import vhost_types.h?

If we were using this file as an include in a C source file, yes, but
we're just using it to generate a string table using regular
expressions:

[acme@quaco perf]$ tools/perf/trace/beauty/vhost_virtio_ioctl.sh
static const char *vhost_virtio_ioctl_cmds[] = {
	[0x00] = "SET_FEATURES",
	[0x01] = "SET_OWNER",
	[0x02] = "RESET_OWNER",
	[0x03] = "SET_MEM_TABLE",
	[0x04] = "SET_LOG_BASE",
	[0x07] = "SET_LOG_FD",
	[0x10] = "SET_VRING_NUM",
	[0x11] = "SET_VRING_ADDR",
	[0x12] = "SET_VRING_BASE",
	[0x13] = "SET_VRING_ENDIAN",
	[0x14] = "GET_VRING_ENDIAN",
	[0x20] = "SET_VRING_KICK",
	[0x21] = "SET_VRING_CALL",
	[0x22] = "SET_VRING_ERR",
	[0x23] = "SET_VRING_BUSYLOOP_TIMEOUT",
	[0x24] = "GET_VRING_BUSYLOOP_TIMEOUT",
	[0x25] = "SET_BACKEND_FEATURES",
	[0x30] = "NET_SET_BACKEND",
	[0x40] = "SCSI_SET_ENDPOINT",
	[0x41] = "SCSI_CLEAR_ENDPOINT",
	[0x42] = "SCSI_GET_ABI_VERSION",
	[0x43] = "SCSI_SET_EVENTS_MISSED",
	[0x44] = "SCSI_GET_EVENTS_MISSED",
	[0x60] = "VSOCK_SET_GUEST_CID",
	[0x61] = "VSOCK_SET_RUNNING",
};
static const char *vhost_virtio_ioctl_read_cmds[] = {
	[0x00] = "GET_FEATURES",
	[0x12] = "GET_VRING_BASE",
	[0x26] = "GET_BACKEND_FEATURES",
};
[acme@quaco perf]$

[acme@quaco perf]$ cat tools/perf/trace/beauty/vhost_virtio_ioctl.sh 
#!/bin/sh
# SPDX-License-Identifier: LGPL-2.1

[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/

printf "static const char *vhost_virtio_ioctl_cmds[] = {\n"
regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
egrep $regex ${header_dir}/vhost.h | \
	sed -r "s/$regex/\2 \1/g"	| \
	sort | xargs printf "\t[%s] = \"%s\",\n"
printf "};\n"

printf "static const char *vhost_virtio_ioctl_read_cmds[] = {\n"
regex='^#[[:space:]]*define[[:space:]]+VHOST_(\w+)[[:space:]]+_IOW?R\([[:space:]]*VHOST_VIRTIO[[:space:]]*,[[:space:]]*(0x[[:xdigit:]]+).*'
egrep $regex ${header_dir}/vhost.h | \
	sed -r "s/$regex/\2 \1/g"	| \
	sort | xargs printf "\t[%s] = \"%s\",\n"
printf "};\n"
[acme@quaco perf]$

This ends up being used in tools/perf/trace/beauty/ioctl.c, after that
trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c file (with the
vhost_virtio_ioctl_read_cmds and vhost_virtio_ioctl_cmds arrays) gets
generated by the tools/perf/Makefile.perf build process:

static size_t ioctl__scnprintf_vhost_virtio_cmd(int nr, int dir, char *bf, size_t size)
{
#include "trace/beauty/generated/ioctl/vhost_virtio_ioctl_array.c"
        static DEFINE_STRARRAY(vhost_virtio_ioctl_cmds, "");
        static DEFINE_STRARRAY(vhost_virtio_ioctl_read_cmds, "");
        struct strarray *s = (dir & _IOC_READ) ? &strarray__vhost_virtio_ioctl_read_cmds : &strarray__vhost_virtio_ioctl_cmds;

        if (nr < s->nr_entries && s->entries[nr] != NULL)
                return scnprintf(bf, size, "VHOST_%s", s->entries[nr]);

        return scnprintf(bf, size, "(%#x, %#x, %#x)", 0xAF, nr, dir);
}

So, if at some point a tool needs to really #include that file, yeah,
then we will need to import vhost_types.h too.

- Arnaldo
