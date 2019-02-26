Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45233C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AAD218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="pUJbkEuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfBZXen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:34:43 -0500
Received: from sonic316-27.consmr.mail.ne1.yahoo.com ([66.163.187.153]:42519
        "EHLO sonic316-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728768AbfBZXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1551224081; bh=EktdXZ+AubJdhKWu5IoDK+BCu7sCQC/kR/8KwY8ETPg=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=pUJbkEuPhHrdVN/Hp6s7OaldakxGdv245xqX68wTL5w+JWU9/aownIUINClH0y2YK93O5imr8Irvp5mWEk+usHZ7ph7nqJpHo/BS3zWd9KcqhoohOCLco6ZhP8rkQBCjsBwgqj+VLxh2GAIWWr6CQTmmAZ7L/r3eiN8jLb7w7ps7x9uF82KcTUtL0rBQwPpIJdOa2YMRuvYRjdQnlWmjkC+74aD3vmuQAqtCis6H4fIs5na3DYQt/rnkDg+ZZYx+mOYzDxio+hgR6Bn9JMzGLhdLwNKZzLR93ekyiqf/6RiNuzYkj9H7LEknu6/tAoX+A6cFh6PciCJ3ZR7hGijvNA==
X-YMail-OSG: 5MqEs4MVM1lNbtjBUFoVqhh2TTWsAMKIAAxYe5_5N35gf1a_jjhwXfA3lbupNKn
 NN.EFyCNeg5M0Mo6V2FoN_k3qAJSS8SlMdtxa1bw2fpyTxB8iF89iUEs8bznQJ6ltfj0gQnes0zg
 tHTNewpzo69tcRD1LXdp8DnlRDWengRXo7Ldh3qsO6uPQb3YnrLTKSuN0cbhFVJDf3oHn5pGjFjK
 CgyXSx08KSpSfhRIFRiLatDcgqKPgp6v4TQgsYfRoX8FXeBeY47lqN773Ef_YgPauGL0XVnjdjan
 QLvCnOtFQMURRGPtug9sZAfQXsk_n0JEPoaBXViz.FFDR_mWo.1biZ5ND9nDLElml1leV2QshPdT
 5tVZvRfFUG4CK1wGo3oZUocbM9ZGsDsevlf6G4vzCcQ3HLOKVFrXK1dDyVaBT0tSgUqsE_v0QC_Q
 7rPLeBr0GGSZ_goXS_6Ggl0MpEmvH8Ej1ODrhPquy90awkEN7lJwenTPV.OH9BtVHh_c33G.1uKE
 CLjJmi0lrInic7nLPaAHy5APhqwPF8QAqeMDVj8WBA_LagP9wzwX4CGt1jFO7RFX7O9zN4OykHeV
 rtOF04M.vR7FQmsTepOMJ8wlsGXGmUeQb7I0nwNbEf.4I4BDEPG.PAmRfxCbRC3o8whL_BQGqE4f
 XVzytwrcehNjk2RaeIVVdf6u05A.I0Ih_n_116LWV1E.D6p9_MsbnHuvDsClCYHjJCyIEyfLoc4U
 Uw4JJsvDpq6okRcWE7nAtNDMma9nMQDcE84hkMG.m9z3.jmYfi5kBe8R8TlQ1Kicjjs.Q.iXTOIf
 DrQsp2DbynCTQluIpfo7HzCR1A0sriZFQHIpMqFURoMMZr4AiTtLYHtuSuiOm3uhgUE6kjtFBIee
 asRMmv9ASXwOfvZ18fMjaPq1em8cveZiyZ6Xu5XtoPq5omDTXgCibgovFtAQYagfc2OKmubkZk_G
 MQsu49P8s0iX_fCnjwUf4IoS8j7gG.o7vjHKF2LTLU4UnSr6ZbgXpukUoi7gy9XZQMPojEMBuKzF
 mkv1JdfscpnyUlPFOzJ_rw6g06VIV1o7NFt7xpEUH6Lff8XBjUx1_x1G389QvwR35or2F3dJkKs0
 GS9JCKYPyfoS4LqpICrTJ6O9j8MxnOtrqHWtV
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Feb 2019 23:34:41 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp425.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 32189341dbc632a409d2d6505fbfc953;
          Tue, 26 Feb 2019 23:34:41 +0000 (UTC)
Subject: Re: [PATCH v2 00/11] LSM documentation update
To:     Denis Efremov <efremov@ispras.ru>,
        Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Eric Paris <eparis@parisplace.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <cover.1551213058.git.efremov@ispras.ru>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8e1c8f44-9f4d-1b05-e5ee-c07bf287a67a@schaufler-ca.com>
Date:   Tue, 26 Feb 2019 15:34:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1551213058.git.efremov@ispras.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/2019 12:49 PM, Denis Efremov wrote:
> Recent "New LSM Hooks" discussion has led me to the
> thought that it might be a good idea to slightly
> update the current documentation. The patchset adds
> nothing new to the documentation, only fixes the old
> description of hooks to reflect their current state.
>
> V2 adds the clarification on arguments for some hooks.
> The format of the documentation is also slightly updated
> for better html. However, there are still 10 hooks without
> documentation at all. I think that this should be fixed
> separatedly.
>
> Denis Efremov (11):
>    LSM: fix documentation for sb_copy_data hook
>    LSM: fix documentation for the syslog hook
>    LSM: fix documentation for the socket_post_create hook
>    LSM: fix documentation for the task_setscheduler hook
>    LSM: fix documentation for the socket_getpeersec_dgram hook
>    LSM: fix documentation for the path_chmod hook
>    LSM: fix documentation for the audit_* hooks
>    LSM: fix documentation for the msg_queue_* hooks
>    LSM: fix documentation for the sem_* hooks
>    LSM: fix documentation for the shm_* hooks
>    LSM: lsm_hooks.h: fix documentation format
>
>   include/linux/lsm_hooks.h | 170 ++++++++++++++++++--------------------
>   1 file changed, 81 insertions(+), 89 deletions(-)

You can mark the series

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

