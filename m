Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226ijwzjTFia+9lhSCTPMwao55jf5tRvQ+ByHIDkFnp4r9OxqV+8pCs07GM10tyckvT+l1tQ
ARC-Seal: i=1; a=rsa-sha256; t=1518226606; cv=none;
        d=google.com; s=arc-20160816;
        b=DDXmyv9o4rJm/cx5b9O/iGymloknBgOwXezbLPWDqsKDSOGMsoxcnHh1ihBUtfDKm+
         B9YYGq8kEzMAB8T7flQQh5d8rIRyDd1J0/gU4F9I9OB9unScWsqWoGy+9/R8RJHvcLi4
         m9UxlLGtjdWVBlasYZUi85D8lyEOCf3CxPky99HUkxjbHecQAKTmwp39SVH2f85tvEAR
         HgHpAbtqpIrcNqCDuyHse0V9QsDLWzbz5AX7zaHK+p4IQy/wtWt3YxHvEIxDTogqU/J/
         tY72LcPfzJPDPToclS1uk88uS/QAuuLFTDekVsn1OjnJ5yjVxDrdd4/jI3YZErmEm5O4
         mVrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-transfer-encoding:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=LbAxzJ+uHxSA8fRPcVYWVHgSPO9uqIK9gZm/dPbI4aw=;
        b=oixvbxToX9ZQuzeeIFRclsku+cu/CwQOUUiGh064DFXZCA0BKTi08rAwc6nZrVh9w5
         UXTmrcuwEoUnKsYhSf5DS5E2jLbkNjX9mHteU0OZFTiIB2IiheAwTJ1Fr7PwEBCAb9UR
         bfTZjYZyYTv7bGYf/iKC20fYDlGJD+sgCmmN6jnRaHyAa5XepV0BqZzKXcz9KtrRuqak
         5Z0dCymT6nI3fPog6pE74XDKxVahTJshSwDA2V3w7n4+zbUQAujcKIMB/dUWk229aGh0
         pOfYpFJTTmd2sYsHr5OyXzASXOU7c6xhvxKhBHb/9bPXZVoPP43/EAf44eqq2F/keR30
         Gkug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=fXQ2nXA/;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=fXQ2nXA/;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeBJBgQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 9 Feb 2018 20:36:16 -0500
Received: from mail-pl0-f45.google.com ([209.85.160.45]:43522 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbeBJBgP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Feb 2018 20:36:15 -0500
Date: Fri, 9 Feb 2018 17:36:11 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Li Zhijian <zhijianx.li@intel.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Philip" <philip.li@intel.com>, netdev@vger.kernel.org
Subject: Re: [Resend] Question: kselftests: bpf/test_maps failed
Message-ID: <20180210013610.hkeblyfx76r2hgzt@ast-mbp>
References: <747824f6-4877-69fe-9f1d-f3c18fed6a01@intel.com>
 <40e0d564-cacb-7608-423e-eb85f5343521@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40e0d564-cacb-7608-423e-eb85f5343521@iogearbox.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591932290259842156?=
X-GMAIL-MSGID: =?utf-8?q?1591975982622861913?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 03:01:57PM +0100, Daniel Borkmann wrote:
> On 02/09/2018 06:14 AM, Li Zhijian wrote:
> > Hi
> > 
> > INTEL 0-Day noticed that bpf/test_maps has different results at different platforms.
> > when it fails, the details are like
> 
> Sorry for the late reply and thanks for reporting! More below:
> 
> > ------------------
> >   880 Failed to create hashmap key=16 value=131072 'Cannot allocate memory'
> >   881 Failed to create hashmap key=8 value=32768 'Cannot allocate memory'
> >   882 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
> >   883 Failed to create hashmap key=16 value=32768 'Cannot allocate memory'
> >   884 Failed to create hashmap key=8 value=16384 'Cannot allocate memory'
> >   885 Failed to create hashmap key=16 value=16384 'Cannot allocate memory'
> >   886 Failed to create hashmap key=8 value=65536 'Cannot allocate memory'
> >   887 Failed to create hashmap key=16 value=131072 'Cannot allocate memory'
> >   888 Failed to create hashmap key=16 value=32768 'Cannot allocate memory'
> >   889 Failed to create hashmap key=16 value=65536 'Cannot allocate memory'
> >   890 Failed to create hashmap key=8 value=65536 'Cannot allocate memory'
> >   891 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
> >   892 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
> >   893 Failed to create hashmap key=16 value=32768 'Cannot allocate memory'
> >   894 Failed to create hashmap key=8 value=16384 'Cannot allocate memory'
> >   895 Failed to create hashmap key=8 value=131072 'Cannot allocate memory'
> >   896 Failed to create hashmap key=16 value=8192 'Cannot allocate memory'
> >   897 Failed to create hashmap key=8 value=32768 'Cannot allocate memory'
> >   898 Failed to create hashmap key=16 value=8192 'Cannot allocate memory'
> >   899 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> >   900 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> >   901 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> >   902 Failed to create hashmap key=16 value=262144 'Cannot allocate memory'
> >   903 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> >   904 Failed to create hashmap key=8 value=262144 'Cannot allocate memory'
> >   905 test_maps: test_maps.c:955: run_parallel: Assertion `status == 0' failed.
> >   906 Aborted
> >   907 not ok 1..3 selftests:  test_maps [FAIL]
> > ------------------
> > 
> > After a simply looking at the code, looks it's related to the cpu number and system memory.
> > 
> > below are the result under different platform
> > 1. Good
> > model: Sandy Bridge
> > nr_node: 1
> > nr_cpu: 4
> > memory: 6G
> > 
> > 2. Good
> > model: qemu-system-x86_64 -enable-kvm
> > nr_cpu: 2
> > memory: 4G
> > 
> > 3. Bad
> > model: Ivytown Ivy Bridge-EP
> > nr_cpu: 48
> > memory: 64G
> > 
> > 4. Bad
> > model: Skylake
> > nr_cpu: 104
> > memory: 64G
> > 
> > I try to change the process number to 10 from 100, so it can pass at above Skylake(4) machine.
> > ------------
> > lizhijian@haswell-OptiPlex-9020:~/lkp/linux/tools/testing/selftests/bpf$ git diff
> > diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> > index 040356e..b788ca1 100644
> > --- a/tools/testing/selftests/bpf/test_maps.c
> > +++ b/tools/testing/selftests/bpf/test_maps.c
> > @@ -960,7 +960,7 @@ static void test_map_stress(void)
> >  {
> >         run_parallel(100, test_hashmap, NULL);
> >         run_parallel(100, test_hashmap_percpu, NULL);
> > -       run_parallel(100, test_hashmap_sizes, NULL);
> > +       run_parallel(10, test_hashmap_sizes, NULL);
> >         run_parallel(100, test_hashmap_walk, NULL);
> >  
> >         run_parallel(100, test_arraymap, NULL);
> 
> Unless Alexei has some better idea, I think if the bpf_create_map() error in
> the stress test is about ENOMEM, then we shouldn't fail hard via exit(), for
> all other cases we should however. So probably makes sense to just check for
> errno == ENOMEM in case of fd < 0 in test_hashmap_sizes() and then continue
> to keep trying under stress. Feel free to send a patch, Li.

that's probably good path for now.
I also see that test_maps fails on freshly booted kernel with such assert,
but then restarting test_maps again works and repeated runs succeed too.
I suspect there is a deeper issue here related to memory allocation.
Either slab or percpu allocator are behaving funky.
It needs to be further debugged.

