Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752313AbeEBP7G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:59:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55009 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeEBP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:59:00 -0400
Subject: Re: [PATCH 2/3] seccomp: Audit attempts to modify the actions_logged
 sysctl
To: Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        Eric Paris <eparis@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-audit@redhat.com, linux-security-module@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <1524856562-22566-1-git-send-email-tyhicks@canonical.com>
 <1524856562-22566-3-git-send-email-tyhicks@canonical.com>
 <CAHC9VhTwrKG2hySCrZaVwHgqyekZXDofkJy9_jCa-CxFgCVUGQ@mail.gmail.com>
 <2326710.O3RjXv44ne@x2>
 <CAHC9VhRW2fcdMK98=sf7otWDQv4N8ZiSFwv7GZmRfN=sCmGHaw@mail.gmail.com>
From: Tyler Hicks <tyhicks@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tyhicks@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <3ead1d7d-9146-8785-9cc9-51eeee3fd250@canonical.com>
Date: Wed, 2 May 2018 10:58:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhRW2fcdMK98=sf7otWDQv4N8ZiSFwv7GZmRfN=sCmGHaw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Uvtlv0K6P8K9pcvHbuUnDREKQzPODPugn"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Uvtlv0K6P8K9pcvHbuUnDREKQzPODPugn
Content-Type: multipart/mixed; boundary="uH714s3gXRxb2cWpTdn9i7lpvhNHXzvoJ";
 protected-headers="v1"
From: Tyler Hicks <tyhicks@canonical.com>
To: Paul Moore <paul@paul-moore.com>, Steve Grubb <sgrubb@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Eric Paris <eparis@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-audit@redhat.com, linux-security-module@vger.kernel.org,
 linux-doc@vger.kernel.org
Message-ID: <3ead1d7d-9146-8785-9cc9-51eeee3fd250@canonical.com>
Subject: Re: [PATCH 2/3] seccomp: Audit attempts to modify the actions_logged
 sysctl
References: <1524856562-22566-1-git-send-email-tyhicks@canonical.com>
 <1524856562-22566-3-git-send-email-tyhicks@canonical.com>
 <CAHC9VhTwrKG2hySCrZaVwHgqyekZXDofkJy9_jCa-CxFgCVUGQ@mail.gmail.com>
 <2326710.O3RjXv44ne@x2>
 <CAHC9VhRW2fcdMK98=sf7otWDQv4N8ZiSFwv7GZmRfN=sCmGHaw@mail.gmail.com>
In-Reply-To: <CAHC9VhRW2fcdMK98=sf7otWDQv4N8ZiSFwv7GZmRfN=sCmGHaw@mail.gmail.com>

--uH714s3gXRxb2cWpTdn9i7lpvhNHXzvoJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05/01/2018 12:25 PM, Paul Moore wrote:
> On Tue, May 1, 2018 at 12:41 PM, Steve Grubb <sgrubb@redhat.com> wrote:=

>> On Tuesday, May 1, 2018 11:18:55 AM EDT Paul Moore wrote:
>>> On Fri, Apr 27, 2018 at 3:16 PM, Tyler Hicks <tyhicks@canonical.com> =
wrote:
>>>> The decision to log a seccomp action will always be subject to the
>>>> value of the kernel.seccomp.actions_logged sysctl, even for processe=
s
>>>> that are being inspected via the audit subsystem, in an upcoming pat=
ch.
>>>> Therefore, we need to emit an audit record on attempts at writing to=
 the
>>>> actions_logged sysctl when auditing is enabled.
>>>>
>>>> This patch updates the write handler for the actions_logged sysctl t=
o
>>>> emit an audit record on attempts to write to the sysctl. Successful
>>>> writes to the sysctl will result in a record that includes a normali=
zed
>>>> list of logged actions in the "actions" field and a "res" field equa=
l to
>>>> 0. Unsuccessful writes to the sysctl will result in a record that
>>>> doesn't include the "actions" field and has a "res" field equal to 1=
=2E
>>>>
>>>> Not all unsuccessful writes to the sysctl are audited. For example, =
an
>>>> audit record will not be emitted if an unprivileged process attempts=
 to
>>>> open the sysctl file for reading since that access control check is =
not
>>>> part of the sysctl's write handler.
>>>>
>>>> Below are some example audit records when writing various strings to=
 the
>>>> actions_logged sysctl.
>>>>
>>>> Writing "not-a-real-action" emits:
>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1524600971.363:119): pid=3D1651 ui=
d=3D0
>>>>  auid=3D1000 tty=3Dpts8 ses=3D1 comm=3D"tee" exe=3D"/usr/bin/tee"
>>>>  op=3Dseccomp-logging res=3D1
>>>>
>>>> Writing "kill_process kill_thread errno trace log" emits:
>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1524601023.982:131): pid=3D1658 ui=
d=3D0
>>>>  auid=3D1000 tty=3Dpts8 ses=3D1 comm=3D"tee" exe=3D"/usr/bin/tee"
>>>>  op=3Dseccomp-logging actions=3D"kill_process kill_thread errno trac=
e log"
>>>>  res=3D0
>>>
>>> I've got some additional comments regarding the fields in the code
>>> below, but it would be good to hear Steve comment on the "actions"
>>> field since his userspace tools are extremely picky about what they
>>> will accept.
>>
>> Its not that the audit user space applications are picky, its that we =
have a
>> coding standard that everyone needs to abide by so that any parser cod=
ed to
>> the specification works.
>=20
> We're getting a bit off track, but the issue with the "specification"
> is that there has not been enough checking and enforcement of the
> "specification" to give it much weight.  We've made some fixes to
> records of lower impact, but I'm not going to merge disruptive record
> changes.  After a while, the status-quo becomes the "specification".
>=20
> At some point in the future I plan to submit patches which disconnect
> the audit data from the record format for in-kernel callers; this is
> really the only way we can enforce any type of record format.  The
> current in-kernel audit API is for too open for misuse and abuse.
>=20
>> In short, we should not have spaces inside the ""
>> because that can trick a naive parser. What we typically do in a situa=
tion
>> like this is add a comma as a separator. But having "" means that the =
value
>> is untrusted and subject to escaping. I don't think that is the case h=
ere.
>> Output is not controlled by the user. Its a list of well known names.
>>
>>> It looks like you are treating the actions as an untrusted string, wh=
ich is
>>> good, so I suspect you are okay, but still
>>
>> The function below that logs names is calling audit_log_format which d=
oes not
>> handle untrusted strings. I would suggest not treating it as an untrus=
ted
>> string, but as a string with no spaces in it.
>>
>> actions=3Dkill_process,kill_thread,errno,trace,log
>=20
> Yes, my mistake, I suspect I was distracted by the comm logging.
>=20
>>>> Writing the string "log log errno trace kill_process kill_thread", w=
hich
>>>> is unordered and contains the log action twice, results in the same
>>>>
>>>> value as the previous example for the actions field:
>>>>  type=3DCONFIG_CHANGE msg=3Daudit(1524601204.365:152): pid=3D1704 ui=
d=3D0
>>>>  auid=3D1000 tty=3Dpts8 ses=3D1 comm=3D"tee" exe=3D"/usr/bin/tee"
>>>>  op=3Dseccomp-logging actions=3D"kill_process kill_thread errno trac=
e log"
>>>>  res=3D0
>>>>
>>>> No audit records are generated when reading the actions_logged sysct=
l.
>>>>
>>>> Suggested-by: Steve Grubb <sgrubb@redhat.com>
>>>> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
>>>> ---
>>>>
>>>>  include/linux/audit.h |  3 +++
>>>>  kernel/auditsc.c      | 37 +++++++++++++++++++++++++++++++++++++
>>>>  kernel/seccomp.c      | 43 ++++++++++++++++++++++++++++++++++------=
---
>>>>  3 files changed, 74 insertions(+), 9 deletions(-)
>>>
>>> ...
>>>
>>>> diff --git a/include/linux/audit.h b/include/linux/audit.h
>>>> index 75d5b03..b311d7d 100644
>>>> --- a/include/linux/audit.h
>>>> +++ b/include/linux/audit.h
>>>> @@ -233,6 +233,7 @@ extern void __audit_inode_child(struct inode *pa=
rent,
>>>>
>>>>                                 const struct dentry *dentry,
>>>>                                 const unsigned char type);
>>>>
>>>>  extern void __audit_seccomp(unsigned long syscall, long signr, int
>>>>  code);
>>>>
>>>> +extern void audit_seccomp_actions_logged(const char *names, int res=
);
>>>>
>>>>  extern void __audit_ptrace(struct task_struct *t);
>>>>
>>>>  static inline bool audit_dummy_context(void)
>>>>
>>>> @@ -502,6 +503,8 @@ static inline void __audit_seccomp(unsigned long=

>>>> syscall, long signr, int code)>
>>>>  { }
>>>>  static inline void audit_seccomp(unsigned long syscall, long signr,=
 int
>>>>  code) { }
>>>>
>>>> +static inline void audit_seccomp_actions_logged(const char *names, =
int
>>>> res) +{ }
>>>>
>>>>  static inline int auditsc_get_stamp(struct audit_context *ctx,
>>>>
>>>>                               struct timespec64 *t, unsigned int *se=
rial)
>>>>
>>>>  {
>>>>
>>>> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>>>> index 4e0a4ac..3496238 100644
>>>> --- a/kernel/auditsc.c
>>>> +++ b/kernel/auditsc.c
>>>> @@ -2478,6 +2478,43 @@ void __audit_seccomp(unsigned long syscall, l=
ong
>>>> signr, int code)>
>>>>         audit_log_end(ab);
>>>>
>>>>  }
>>>>
>>>> +void audit_seccomp_actions_logged(const char *names, int res)
>>>> +{
>>>> +       struct tty_struct *tty;
>>>> +       const struct cred *cred;
>>>> +       struct audit_buffer *ab;
>>>> +       char comm[sizeof(current->comm)];
>>>> +
>>>> +       if (!audit_enabled)
>>>> +               return;
>>>> +
>>>> +       ab =3D audit_log_start(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE=
);
>>>> +       if (unlikely(!ab))
>>>> +               return;
>>>
>>> Instead of NULL, let's pass current->audit_context to
>>> audit_log_start().  Yes, most of the AUDIT_CONFIG_CHANGE users pass
>>> NULL but all of that is going to need to change because of 1) the
>>> audit container ID work and 2) it makes sense to connect records that=

>>> are related.  Let's do it right the first time here :)
>>>
>>>> +       cred =3D current_cred();
>>>> +       tty =3D audit_get_tty(current);
>>>> +       audit_log_format(ab, "pid=3D%d uid=3D%u auid=3D%u tty=3D%s s=
es=3D%u",
>>>> +                        task_tgid_nr(current),
>>>> +                        from_kuid(&init_user_ns, cred->uid),
>>>> +                        from_kuid(&init_user_ns,
>>>> +                        audit_get_loginuid(current)),
>>>> +                        tty ? tty_name(tty) : "(none)",
>>>> +                        audit_get_sessionid(current));
>>>> +       audit_put_tty(tty);
>>>> +       audit_log_task_context(ab);
>>>> +       audit_log_format(ab, " comm=3D");
>>>> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));=

>>>> +       audit_log_d_path_exe(ab, current->mm);
>>>> +       audit_log_format(ab, " op=3Dseccomp-logging");
>>>> +       if (names)
>>>> +               audit_log_format(ab, " actions=3D\"%s\"", names);
>>>> +
>>>> +       audit_log_format(ab, " res=3D%d", res);
>>>> +       audit_log_end(ab);
>>>
>>> One of the benefits of using current->audit_context is that we get a
>>> lot of this info from the associated SYSCALL record (assuming the
>>> admin isn't filtering that, e.g. Fedora defaults).  We can safely dro=
p
>>> most everything except for the "op" and "actions" fields.
>>>
>>> Steve might also want an "old-actions" field, but I'll let him speak =
to
>>> that.
>>
>> Configuration changes are supposed to show current and new values.
>>
>> -Steve

All of the feedback received for this patch set is addressed in v2:

 https://lkml.kernel.org/r/<1525276400-7161-1-git-send-email-tyhicks@cano=
nical.com>
Thanks for the reviews!

Tyler


--uH714s3gXRxb2cWpTdn9i7lpvhNHXzvoJ--

--Uvtlv0K6P8K9pcvHbuUnDREKQzPODPugn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEPgU+cN5AsTrekT5+1pIAPaoCxwoFAlrp4DMACgkQ1pIAPaoC
xwqK2Q//W7VaU5wzber1LPIo4/rWq6eGVjv6uQDOSc+2JTId8R19WVKVpDU8iZA6
cNYn8t+nePxG/e6qFGnAm1/CKmPMmDJwUukGYTj1X5wTORz9x43w6/InBoRi/0gZ
CVbBuqV5OpgYjD6j7P0DMuivkngbCsLItzlZEtFH3R02evcaOTbSY5d77ZOzM0FM
EJtPja2C79dDBLjO557xJ2zRt8xM7ZpE9tCoJv0iXVAjjYgtIEzoqiO8X49ZjrD7
3GZ5VxZIU94LoyslUnnKFbK+XXw43WxOo/x0eEZBKNRA9FokPqK+r/JsQSlb1T4m
v1jEfrvF/sY0Xod6E0on9uR0BFfwtHdCi3EjTVgLMDVeCh69nijFpemBvscdpJlN
fm9LUrqNgb9F4ftkFzEeapG+LZ4TPAqK5bcd/517+A7WNK0DRprSwNSuGofisK6j
1+QV8CScaZaImyLbbt5JngKI5/yZjz+areaE92dwjOieTYvoB2Dwb9rk11eSVngd
vkZzpsY1eafcrWxvhGeQvT1HJOG5h7l6R9bycRAhreJyzWJY/8z3/YJSTPVFSExj
w03Tc9NLCN8zXVVaVEWI5dF1afSs53tYC6NlkaMgksWtQzeadloOlrm+qfQl+eRa
NJbE9rqTwH8gSzyiChXjRt3bww8JrWa5LBXHJKgGHUDI1VxEoqw=
=nBx7
-----END PGP SIGNATURE-----

--Uvtlv0K6P8K9pcvHbuUnDREKQzPODPugn--
