Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-539844-1523803490-2-17901849757666335151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523803489; b=Asq214FeVQrX7rgYjHyYTyABDTXp6OLceAVo6QJEbQSJjy3U/Q
    2+1lIflQTDj/E77qwTx0DeqUCnUQamNoTeO/UxijxnzQHc5yZX4/Lq4+0q6q1GCJ
    t29quKWwa72q/UOiPNR17Dqw5LGYW5HaP9U/9ET08FHcR+V0MUv6ISUWlZK1bLLz
    TIOMkZThh0Hy0gIVXOxLvq5r7gAaf2lS41Sk/M6zdjePwGiUgRDKrIDQHUcOuDjh
    N1U2u2hLpw2J+7xDk1sHmE4MP9ikC88TtxkCwZFKP4y/2Spk288visD9qh4+IMto
    qNhFfcOafafmzHJjPhVJw+/HGD6buNUkz1FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523803489; bh=/WCryBd9VzOzpYgFtzgBQew3l6acjwTMOlgYARTrMmM=; b=
    nlv4OhJC/4lM39VzAzpmexZZ/KmxQN6BEHj3Bbh2dsVmnnEpnDksbaEegI7/pj2A
    ENZ3Qr2EOjD0jvuTFK5FGxhM7m1WQJFtALvyapAbBGRqtaI7uhZu6D+JQXuvZr/L
    GrJY25GHOK4dRg5iogT4arRR6F66fsU5sWlTQy0rmP9WZz0frwNQ58NiaBos8CYY
    Ng4O1JwR29sr2i8fiNWoRWVjgtI7BSQ4lQDrquk5E60rN0Y6KCYVK7bBSiEMBxnr
    bEu+CWi721xNkKhTWMCHbNSI8W38WloLHd6Bqz4XkLhjNQPkVoEMrMFHiuXdLPol
    7WFJfOqGUq62sp5hMFYWuA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FLa0k2ot x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=FLa0k2ot x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPji248S9IE1UF7f4KIY3mb3PCJ1n540oIzXkgI+Xx9wQKALQ6Zdx9IyO1AMm1x0pjNyq0VCNbATVdSGaAoJg90IaFRibVzsEB+XD+/G62kMe8kjxrZx
    CR4XuYEcPfkY7gdAru/8Jgj72APbpbSFDBz7am1ehViNr/Nmsxa0AE0POhowG7St4NNhmVGlp70Sa6NhL/rJYeFpKmglXA7y2KQPo1YEOQQj/1w0yMGbJsCO
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=EHaNKQqtAAAA:8 a=fBoPh2XHPsMqvhPwQAoA:9 a=CjuIK1q_8ugA:10
    a=KIA0-nbnOXq3vJi0w304:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeDOOos (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 10:44:48 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:6112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752457AbeDOOor (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 10:44:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: James Hogan <jhogan@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around
 config2 misreporting associativity
Thread-Topic: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around
 config2 misreporting associativity
Thread-Index: AQHTz5iLqRoxliRgSEKMEGprDVcqeKP43ecAgAkTfIA=
Date: Sun, 15 Apr 2018 14:44:45 +0000
Message-ID: <20180415144443.GR2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-43-alexander.levin@microsoft.com>
 <20180409200838.GB17347@saruman>
In-Reply-To: <20180409200838.GB17347@saruman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:Q++DI3ASyEbCG5EVKjNslATTlF2txQh+AtKqxNXOGMU6r7Jk9+xKOR/qjRevx9us/EBokjVcrXq65jqwQw3DT7QZ5Kylz3WByXuDWvTLRUps1UvGrCHYYiJqguaR2PV7KOzXU6DjVlM/Gt8zOtNDYZOHZWqBvz29+V1IbAtthzsGtygJUBKi7aR8QP55rx1bNvxyGZMsY6hv/axt0uXCVHMWJ6zwOjoDWYAka2u/tFaBAcZhXvJhTtD9bhX81TGY;20:d5MOXPuEmSRApExA3HlWA8lzY753WXwS5PDiaJPVhsvWPmkXOMZimwfGer3MsL/UlmnngVp/mCEyUY4VnGO38Y84oIW4IgSdGdmcyOu/3FGibvWroC1pgn26XWGLB7TxDK8XTdUClbDqoMDJ0KPCIA/VnlAOm/NjBJbusPSFMfc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983E356357457C7833E7953FBB10@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501347)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(396003)(39380400002)(376002)(39860400002)(346002)(199004)(189003)(6506007)(5250100002)(7736002)(102836004)(229853002)(6916009)(9686003)(6512007)(99286004)(76176011)(305945005)(33896004)(2906002)(1076002)(575784001)(86362001)(3660700001)(86612001)(53936002)(2900100001)(106356001)(3280700002)(105586002)(33656002)(6246003)(486006)(22452003)(10090500001)(14454004)(476003)(11346002)(72206003)(446003)(25786009)(26005)(6116002)(3846002)(66066001)(33716001)(6486002)(4326008)(68736007)(186003)(5660300001)(316002)(10290500003)(97736004)(8936002)(8676002)(81166006)(81156014)(6436002)(478600001)(54906003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: l41PTpopSZeySvanoB+L8z6kaT/U0fBkHzTJMSPGmPplYIkX4b2+7an50XRsY4iA51XPp/LKw7EJ1eUtAFEAID0PlfVhGqLg4jV3pGcau58V968GDMLSGa046asDJpEHntgNRYwGtP8BaAUWK0D6F1tB6CmHYoGKe38DNk24xcTh5Lz7B3Zi3xdWjLzhOBnD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A4189D4C1E5693469236E6E4724659E0@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 46ab6969-bcf2-4ba9-90d8-08d5a2df6e32
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab6969-bcf2-4ba9-90d8-08d5a2df6e32
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:44:45.1486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 09:08:38PM +0100, James Hogan wrote:
>On Mon, Apr 09, 2018 at 12:20:20AM +0000, Sasha Levin wrote:
>> From: Maarten ter Huurne <maarten@treewalker.org>
>>
>> [ Upstream commit 1f7412e0e2f327fe7dc5a0c2fc36d7b319d05d47 ]
>>
>> According to config2, the associativity would be 5-ways, but the
>> documentation states 4-ways, which also matches the documented
>> L2 cache size of 256 kB.
>
>JZ4770 support is new in 4.16, so no need for this to be backported.
>More likely it'll just break the build due to references to
>MACH_INGENIC_JZ4770.
>
>Cheers
>James

Now removed, thanks James!=
