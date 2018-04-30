Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2081085-1525127912-5-2538627763715917532
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525127912; b=IlGszWjJssp/jbljoud3nnDxk+DDLOsGqQ2b8YyrfFhNZTWNcg
    g6xZ0lkBeckJHU8SwfCcWF1mTJLVKW4t66Lju01k1vG/ePGQQ6B3nKbvFbs+6dzr
    wP6mnL96+SnYZfg5T/hdBxvCHIZF8cNv+Tq0w6MaU77W67tRnlyNrJ8GkdDF9lbF
    mEfXaD2LwlD2V23om89MGladU95FjSBsOGfI9lp4/giDL+wJ4ThEPM9lvnr77aZT
    Xg7eS2FFRX6n3FrOLBuEYb6m07bK2vih0FVK8t/nsleCtXkgW4q2/20GL1ZfXoyJ
    k4G1rreFOYFem3aN3J701DBxrWLwF+s7paRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525127912; bh=1wSBW
    Qqtk20IaBcw4yrHd0PY3QSih+D+3KM9IYI/jxk=; b=LLVJzgRi0KBFsmRNXUAHw
    Sp5D78xnrb/KiujsOAfWNz0vMwbPVG6JVkqSGFG+qVPkadxK9D4KSSl+sdJNaSkO
    Nk7NT1abvtoG3Fn0OsHyEVrvlGm1DAjIq9UmzL6aH1OzrM9SgjXSKO5Yzy9OMb9j
    AdN0t20obHLhBZ+dGyY5d0JICd3Se5s9DL6qYAR5g3DbqeotDhjwoTxFhPlRHZg6
    Z8rauGVqElT6rUCn2UBMhC4W+M462T/GkBZl4W6IdWIchxBtIH444PLL+U6NEGJO
    cyaMiQnLiMccCUkC3ssly82kJ94OvUX76o2TkJQ47lK41JscoXZ5F2rojkfG8P/r
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=a3mWNAgI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jPzu5u6w;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=a3mWNAgI x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jPzu5u6w;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK4LDxXusKAGm9cJV3MH0R3gicha8/Lty5FzT1VkM7jekURjCpd/oco1YH85rmp+z4yDKJei3l+bLU5J9uGUML21PubuuTVUhfj/+cWyaIz+S0t3dLFA
    w9WjpeKSlbz1Pg/4HCGPFvDdar+9fLl0VOd1Eh3Ri7V0jjfgtIHBcu8c6z5qjPt5qer6CbVkmolHtjjFwyV5VPIzHWIQQv8a5LCK5aqJq8Ze+50TFusSM3Vq
    YcIHjShElNsLX+xd8Ufgbg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=5mpuRNi4AAAA:8 a=D19gQVrFAAAA:8
    a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=DDOyTI_5AAAA:8 a=jRiZTb-mZS3jeCMx630A:9
    a=CjuIK1q_8ugA:10 a=eHWn0xJZPbZ7L6UZR85b:22 a=W4TVW4IDbPiebHqcZpNg:22
    a=xmb-EsYY8bH0VWELuYED:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqp8c6VrpRZU13k+07BBK4UeqP6m2PtNQLBN1Fl5FkOfFe91avnFojvOTDs2cb078AegNK8PR6gZiOo0+SQvHw=
MIME-Version: 1.0
In-Reply-To: <1524930469-14174-3-git-send-email-stefan.wahren@i2se.com>
References: <1524930469-14174-1-git-send-email-stefan.wahren@i2se.com>
 <1524930469-14174-3-git-send-email-stefan.wahren@i2se.com>
From: Kees Cook <keescook@google.com>
Date: Mon, 30 Apr 2018 15:38:22 -0700
Message-ID: <CAGXu5jLHgKg=c69v80qFWeyE8djU3+2ruQu0HvUxT3MMRmd72A@mail.gmail.com>
Subject: Re: [PATCH V2 2/9] staging: vchiq_arm: Clear VLA warning
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Phil Elwell <phil@raspberrypi.org>,
 LKML <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 28, 2018 at 8:47 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The kernel would like to have all stack VLA usage removed[1]. The array
> here is fixed (declared with a const variable) but it appears like a VLA
> to the compiler. Also, currently we are putting 768 bytes on the
> stack. This function is only called on the error path so performance is
> not critical, let's just allocate the memory instead of using the
> stack. This saves stack space and removes the VLA build warning.
>
> kmalloc a buffer for dumping state instead of using the stack.
>
> [1]: https://lkml.org/lkml/2018/3/7/621
>
> CC: Kees Cook <keescook@google.com>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../vc04_services/interface/vchiq_arm/vchiq_arm.c  | 25 ++++++++++++++--------
>  1 file changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 8575bd8..d46a5b8 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -3415,13 +3415,18 @@ vchiq_release_service(VCHIQ_SERVICE_HANDLE_T handle)
>         return ret;
>  }
>
> +struct service_data_struct {
> +       int fourcc;
> +       int clientid;
> +       int use_count;
> +};
> +
>  void
>  vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
>  {
>         VCHIQ_ARM_STATE_T *arm_state = vchiq_platform_get_arm_state(state);
> +       struct service_data_struct *service_data;
>         int i, j = 0;
> -       /* Only dump 64 services */
> -       static const int local_max_services = 64;
>         /* If there's more than 64 services, only dump ones with
>          * non-zero counts */
>         int only_nonzero = 0;
> @@ -3432,25 +3437,25 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
>         int peer_count;
>         int vc_use_count;
>         int active_services;
> -       struct service_data_struct {
> -               int fourcc;
> -               int clientid;
> -               int use_count;
> -       } service_data[local_max_services];
>
>         if (!arm_state)
>                 return;
>
> +       service_data = kmalloc_array(MAX_SERVICES, sizeof(*service_data),
> +                                    GFP_KERNEL);
> +       if (!service_data)
> +               return;
> +
>         read_lock_bh(&arm_state->susp_res_lock);
>         vc_suspend_state = arm_state->vc_suspend_state;
>         vc_resume_state  = arm_state->vc_resume_state;
>         peer_count = arm_state->peer_use_count;
>         vc_use_count = arm_state->videocore_use_count;
>         active_services = state->unused_service;
> -       if (active_services > local_max_services)
> +       if (active_services > MAX_SERVICES)
>                 only_nonzero = 1;
>
> -       for (i = 0; (i < active_services) && (j < local_max_services); i++) {
> +       for (i = 0; (i < active_services) && (j < MAX_SERVICES); i++) {
>                 VCHIQ_SERVICE_T *service_ptr = state->services[i];
>
>                 if (!service_ptr)
> @@ -3494,6 +3499,8 @@ vchiq_dump_service_use_state(VCHIQ_STATE_T *state)
>         vchiq_log_warning(vchiq_susp_log_level,
>                 "--- Overall vchiq instance use count %d", vc_use_count);
>
> +       kfree(service_data);
> +
>         vchiq_dump_platform_use_state(state);
>  }
>
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
