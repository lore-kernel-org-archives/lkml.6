Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9C621872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OP11XKB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbfADREx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:04:53 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37492 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfADREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:04:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so25867602lfj.4;
        Fri, 04 Jan 2019 09:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPwdrPgYKuj+pzpOkqIksg/4AsD94nApsdfWtGw36KM=;
        b=OP11XKB/MCSKd1XfcEG2/O7+/0JM7YNFS18hWXUndT55Q+jr+USbKH+0+8e5MZPCn+
         9yQ1aYHbxGkHBDYhmDpsJwF3ejlRiND5eaKvKwfjGihtp1J8L5jIyyYO/AUY1hVwmW1V
         uEhNmt1F51xDh9nc7+6Xkd1ho/YKaRfoKaPkdgV46cK0E5Zliv96lT6GIUvnPCl7iAUj
         N84degIqB+doMmx3QtIuM9SPgH5Xl9lLDdND9c0EBUDjx8KEWwTWsHdnJOS+HxkIm4lA
         xssfZcd9j4SF/QgqnZB9Dmpdmo574NqQfFgPZEKIyaBlcFuVnDrLElaAZLWZa/YEeLow
         uNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPwdrPgYKuj+pzpOkqIksg/4AsD94nApsdfWtGw36KM=;
        b=ngRlXHaIA4zxodUwENxFQBW6Byxxqb0VGd4IVMB5xk5kyz4czSWOBCxXtzJWmk86Zk
         uqHt1jWKwd+VwbZIPuuoUOzbPAwst0Rn/EL5weg/+skpJr+5YZXF4D08866qEOtdwBqU
         Zf/tUhy7FBrj0qfexjPazpDl5neq9FLVy6QEfMytsJLw33yKpw20fz+m3+fXF4NojY0R
         JeriWAUcuL9sHoBTNa9/ZXeoVP4vUq6nQ3MVxykkL6SVYch5sTWlLBf6RqT9rpr705MV
         1Kug2yvKmq/UCzBdflYAs9dmvmJJwD3o0JkNKVY9xyQiANkfXTnaSLnh2KZVZHUzQPO3
         I5eg==
X-Gm-Message-State: AA+aEWahNTtaKMdWahMvFKz6P61G7z/KXCFlm+N8pSJAKw23VZy9Ug0J
        OF1tddv+mwacHvzLhez+GiJpKhiIIRUfIMIU4yE=
X-Google-Smtp-Source: AFSGD/WGQlq8DCLgAPCXyfsvZs3BMxrId7lb+zOaqC8D/rzGY+1jIgU0BnxQ5Gq9i2XRdhT4twtnE5XhAIZsCHaOkRk=
X-Received: by 2002:a19:c18d:: with SMTP id r135mr24075542lff.59.1546621489627;
 Fri, 04 Jan 2019 09:04:49 -0800 (PST)
MIME-Version: 1.0
References: <CAE5jQCch70ZSmGZeA6RQxjXhL=LjgShdj_VZAGmqUzVRPSQBZw@mail.gmail.com>
 <CAO-hwJK29V7gT3WQXLvsM5qaQgRLsgm2HAnR81vtkrrQAsCuEg@mail.gmail.com> <CAEc3jaAf2Cd_1vS8Xo-VoJzJKxWJDNm++=eY+5G2dHa5Jo2gXg@mail.gmail.com>
In-Reply-To: <CAEc3jaAf2Cd_1vS8Xo-VoJzJKxWJDNm++=eY+5G2dHa5Jo2gXg@mail.gmail.com>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Fri, 4 Jan 2019 20:04:38 +0300
Message-ID: <CAE5jQCfPCSe3eCRnjt2WzF0-SVYY7yM=KuAYS5_p7Gz0CmQy4w@mail.gmail.com>
Subject: Re: NULL pointer dereference when writing fuzzed data to /dev/uhid
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007e39f1057ea4e02b"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007e39f1057ea4e02b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Would you be able to share the sony.bin file?
Sent it in this message.

> Did you inject a particular device?
If you are asking me, then no, I blindly send fuzzed data with a
simple (but quite large and not very meaningful) header. That time it
just turned out to be Sony-like descriptor :)

Best regards
Anatoly

=D0=BF=D1=82, 4 =D1=8F=D0=BD=D0=B2. 2019 =D0=B3. =D0=B2 19:38, Roderick Col=
enbrander <thunderbird2k@gmail.com>:
>
> > > For sony.bin:
> > >
> > > root@kvm-xfstests:~# cat /vtmp/sony.bin > /dev/uhid
> > > [   16.891931] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.892432] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.892894] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.893362] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.893844] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.895389] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.898165] sony 0003:054C:1000.0001: ignoring exceeding usage max
> > > [   16.901190] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.903797] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.906401] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.908957] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.911449] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.913936] sony 0003:054C:1000.0001: unknown main item tag 0x1
> > > [   16.916551] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.918454] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.919743] sony 0003:054C:1000.0001: unknown main item tag 0x4
> > > [   16.920834] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > > [   16.921904] sony 0003:054C:1000.0001: unknown main item tag 0xe
> > > [   16.923006] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.924082] sony 0003:054C:1000.0001: unknown main item tag 0x2
> > > [   16.925195] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.926289] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.927400] sony 0003:054C:1000.0001: unknown main item tag 0x0
> > > [   16.928546] BUG: unable to handle kernel NULL pointer dereference
> > > at 0000000000000028
> > > [   16.929951] #PF error: [normal kernel read fault]
> > > [   16.930884] PGD 800000007a52b067 P4D 800000007a52b067 PUD 0
> > > [   16.931836] Oops: 0000 [#1] SMP PTI
> > > [   16.932437] CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted
> > > 4.20.0-xfstests-10979-g96d4f267e40 #1
> > > [   16.933752] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS 1.11.1-1ubuntu1 04/01/2014
> > > [   16.935372] Workqueue: events uhid_device_add_worker
> > > [   16.936321] RIP: 0010:hid_validate_values+0x48/0x110
> >
> > In a sense, it's good to have a fault there because this was added to
> > make sure we do not blindly accept any data. The fact that it doesn't
> > fail gracefully is a sign that there is something else.
> > Maybe Roderick could have a look?
> >
> > Cheers,
> > Benjamin
> >
>
> Sure I can have a look. Would you be able to share the sony.bin file?
> Did you inject a particular device? We do a lot of remapping and
> processing in hid-sony at startup. It is probably related to that.
>
> Thanks,
> Roderick

--0000000000007e39f1057ea4e02b
Content-Type: application/octet-stream; name="sony.bin"
Content-Disposition: attachment; filename="sony.bin"
Content-Transfer-Encoding: base64
Content-ID: <f_jqiac7wv0>
X-Attachment-Id: f_jqiac7wv0

CwAAAGEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAYQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAGEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABkAAMATAUAAAAQAAAeXeb/CwAAZIUBALAB
ADgACwsAAgAAAaMAvkIHBQEpAAGuAAABDwCjEBUCKsAJBeyjAUAAARCjFs6BFMAJHgsgAAIACgEL
CwAACQDtO4KW6gEAAEDg4xWAwAkBEKsUHvP9IMAAAf8AvkIHBQEFAP///+wAAOb/AAAKAOkAAAAA
AAAAAAED6N/+AL4zBwUBBXYAAAEAAAAAAAAAQAAAAAAAAAACAAAABAAAASkAFgAAAQEAAfAAAQAA
AAEPAAACBgIqJQkF7AAB
--0000000000007e39f1057ea4e02b--
