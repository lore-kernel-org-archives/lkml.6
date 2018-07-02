Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7069C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CA424563
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2h5fCnmF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CA424563
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeGBQec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:34:32 -0400
Received: from mail-co1nam03on0063.outbound.protection.outlook.com ([104.47.40.63]:63232
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752211AbeGBQea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weOTjaZKJeWijnkDfdJDFZh8nn8k8Akg+/SQJWS50WE=;
 b=2h5fCnmF/8N6IdEMz4ayCY+Jg9rj3pdk8mkkWuyOF1UFSXTOPw4O+HSCcwMVJx/vpj4YVbqrGEWPljWmhOB1lCx2HoM1J9u45pS/w0ndHM84ZEaJnK5e5wBCkaQJzQtrrNbiXsWB5MRboapMoiJPsOG88yY4wMF4+OGr0mxbjLg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
Received: from [10.236.136.62] (165.204.77.1) by
 SN1PR12MB2461.namprd12.prod.outlook.com (2603:10b6:802:27::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.25; Mon, 2 Jul 2018 16:34:27 +0000
Cc:     brijesh.singh@amd.com, Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v2] x86/kvm/Kconfig: Ensure CRYPTO_DEV_CCP_DD state at
 minimum matches KVM_AMD
To:     Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1530117053-45869-1-git-send-email-Janakarajan.Natarajan@amd.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <d884aed7-6c64-5e83-243b-e6ca6be543a0@amd.com>
Date:   Mon, 2 Jul 2018 11:34:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530117053-45869-1-git-send-email-Janakarajan.Natarajan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0201CA0002.namprd02.prod.outlook.com
 (2603:10b6:803:2b::12) To SN1PR12MB2461.namprd12.prod.outlook.com
 (2603:10b6:802:27::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fd2b2e0-e876-41f4-c8b5-08d5e039addc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2461;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2461;3:lyGWUdZXYXluV2caKI9CtTS92VkY32qoe0/pW68ANK40xtGkCfGx3gtKaer5iU/91eGWTbGXvNU6cfGMEBf+FukWwrXqYv+2bQ/jyWXA2pWzO/MK7CYT3u96PuGwuRsXjUxpzrDswFDq5Pd0k7uqoOT0FFSYcWbEKQKx+TLanoJXI3soQgI0ZUAb5fPGPKQYpBsLIhCSKWHew6blrYixxtFhVUdS31IYg3ozncJkJS0tcyBHu7W2vz73XiE7rMpA;25:VjnfLvO/JrmTvhLifeWZk/qd8RDoFa629Zv5TN/jauPjRwTOpFPaT4OA+R7xBFNYIKn/3G4dr30RMIfAlvHBnVeL7EHdsMD9Pqvi2EIhqqPLB2C/Z4NHn2OckQLBKFiXbMjkbdSXXgX8JEAPdxg5UYu+ppLy/1Kv6NS4zkn1MGmzXPKR5xae48AlxbqAqCjNs5EEuXVovdvZ91iS2ZFRxxYv2rgH+xDjfpTgAq8KP+UIMi1jm2W7/BhYR7S2K29pIswDsTID5+MdOM5Ctz9VJnjBtNtBEdvO01Nl0yOOCkBtPIPTUWtTn1XpACvD3zkJJ6F7xlx1QlbQ9I2ySY+nUA==;31:WMaq/nYzjQdN+BHCC75wW7BdMjmPJTIcqxjy52MS57h3qS1LoeuZAUcWJyTZhRMAcjQt9OGikzIfEDVXIp2+GrFBS+32oM5bfgayEcf/noBAWY94SVbnbPtATbKcCkwYuvrwK/OXUhX4GaaNYOtXRiSGBweo06DaNkz7nlk9fH2jaghxC8iRFWFeIeDuKfc0PgPSbajfgZyfu3vziUja7IcuGct42kTc/Qe4WRMox6A=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2461:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2461;20:ak+m14KYSdk+HFvI/D2iVQNgmzKz1gVywA+V7TsRH5jZWN+k5OKsPlJ2QywRER4Hu4l610npI7f3xKSUbTA86UzJhbmO/OAT82WfieMS1fOIaAEI/IhmA/GEmsJtN9zY/hwZKffrka9QLCFcUpgwtyhlqf8sQ0k/u/5y+YjRiVxGenZTRDuN4xpfQkhO3/9tErpTup1izaVKJrTBc2KNX7bPvvw3bdK8hiElyTXynCwCPKjMq2SyU3g6ZGlePo62SoficBJ4P3snTQzX7fqv6VScf8wCaZIfAvjNJkMpgfBlldXiKw2+Q/1RQEWg7RyZAaaxbwiQg2iOo7Qc1ETidp5lm2IgdRvnZsNGK0nQpKS7PDr9UF//PAGKhbTn4M5GRpeGoAD+ql6M24aaxpManIVEiUEXxtvREw/fxsG5a/i34vhdNU/TauCfXdqtmcGhlMu49c3+Y9kOx+vfoik/6OM1l3lr51c2/O8si2BexhyZvwNB09MgKWMQO9N0Ybho;4:Pa53s5DLjpLvuwEXMna94x8o/893Vldi6xLOzD2yWsm/Awbx7esZjwvtLxhRWJ4o5hMp8EXAxTcM+nFu8MP7B5b8id1WaUBZHXfqLpkWmz/gGz/BKiFF4r3EcXtzCfaxvz1ein9YFX9og80c/WHVOeTFA6lsovQEnp8pEtF+6ZXM/tJFPt0geJi+1fhiahY4zHWYt9H4B38EtxhIf0ohyUFetCi3dn9fo/insWCRu1TaJRfYSc/mdE/OGSjhZBzIoHJM47dVTIcsR9XZZJmkldP9lUgt69IytCdPFzaPLpYOQ7fuL5o+wMJWhJT/2zIXvAc0o1/+hF3N39kYOwvY1Q==
X-Microsoft-Antispam-PRVS: <SN1PR12MB24618FEB4098AAC587967D2EE5430@SN1PR12MB2461.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2461;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2461;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(136003)(346002)(396003)(366004)(376002)(189003)(199004)(25786009)(7736002)(305945005)(956004)(2616005)(476003)(8676002)(105586002)(44832011)(6116002)(5660300001)(106356001)(446003)(11346002)(6666003)(14444005)(3846002)(81166006)(50466002)(65826007)(4326008)(6246003)(86362001)(53936002)(31696002)(486006)(67846002)(81156014)(8936002)(31686004)(16576012)(316002)(54906003)(47776003)(16526019)(186003)(229853002)(76176011)(58126008)(68736007)(64126003)(2486003)(65806001)(478600001)(97736004)(65956001)(66066001)(52146003)(230700001)(6486002)(77096007)(26005)(23676004)(52116002)(36756003)(53546011)(386003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2461;H:[10.236.136.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIyNDYxOzIzOjhqSTR4QnpkV0FHRkFZenVKMnBjSTBiVzhj?=
 =?utf-8?B?cTB1WS9Pa3ZlUHQzMEk2T25YZlFVcWprakxlQisxejNqenpjeDR0TCttazUv?=
 =?utf-8?B?ei94VkxEeUk4T0loTFlPZVlkWmk3eEl3K1pUaU9SUUdkUEpUUnV6cjFxMk9M?=
 =?utf-8?B?SkJmZXNUemhMLzc1YzI4SzdDL3Nzd21rbFhxcE9MZDZCRS9YdXhXUTBDYWIr?=
 =?utf-8?B?RTBlTkIyMHVRRUF2UkZybDQwUFNLZWdjQ0ZJTUpINlVQY1IveUd4T0M0NUhG?=
 =?utf-8?B?anphRC83UXM4bkVyaWgxcXpFL09oWVUvemluVGZGVEJ3Z3pWOVNZTkxVbk5z?=
 =?utf-8?B?SDhCRndBMzNqc3ZvRUQyTjN1OW9Xbmd3bmdSLzl3MEEyS2Y1N0dYQjJqZVc2?=
 =?utf-8?B?b0xsUmM0WkMvamhIUkJXMExycjJjMURleHlxbjQwenZZNTc1azhTL0JaZjhX?=
 =?utf-8?B?QmphVVVRUVdqM3dxQWQvNmNETUZRY3IyTk54andZaW9hSnVpUWtDZFlHNXJR?=
 =?utf-8?B?dXczc1lHNlZFczdpTE5EeHB4RE5IdVlySEs2U2FicGZkME5TQ0pKU3FxMkVx?=
 =?utf-8?B?cUptTnJ5WEd6TW41QU9lU1l0NVM4YVdtU1lTRDRFTDNOSTBVWEhBdmhPamZq?=
 =?utf-8?B?U2pHTTRDbEtjb2grcXU1ZmVHLzBDUVMwenZLY29vV3A0TmVKekZ0QTd4T0Vv?=
 =?utf-8?B?d0hWc2N3VDlJTnhRWE5HUXFsSm03Y1VieFlXYjhSS2dUV25KY0U3TmJMT1d6?=
 =?utf-8?B?dVd3cUlVK3FKR3EveCtzYU4wbzhyU2ZWVWhSRG9XRXF4ZW11dW1QWHBobytG?=
 =?utf-8?B?THlDNGxpcnhEbC9PRTRqWGNhWE5haXAzclVRVzl3YnBYcXZtYko3elh5bXdF?=
 =?utf-8?B?Rzh1MS9GbWdrQlBrcnIrZkM3WmUxTmFsTWFieThoNWVKZG1zUFJEallZaFc1?=
 =?utf-8?B?VzJtY1NHOEc2ZFJRWmt3bFlNbUtwcEo1aDZ3MUtaRG80NEt5b3NPSGV3RW9h?=
 =?utf-8?B?dkg5UzhyQmdpNUFOTXhjZGttbnduSVBnMlRiUERTSTRpUU52eVM5cElhUE5O?=
 =?utf-8?B?VFB4V0F3SjNrbmZrM1hocWNEdVBJaHJrZlhXWVQ5WjNnTWRDTSszN0dqS2Nq?=
 =?utf-8?B?VTJWUmRnczlXc01OVU5QamdXdlRKVnI1WW8rN0NCZWVPYTdxaStsbzR1UU9u?=
 =?utf-8?B?NG9jb2NvM05RdFNnaDZYeGQvaURRV083RGllNHQrWWh3czBJdXgyV3IxWktG?=
 =?utf-8?B?d2Y1b3VyYzdzQU1VOG12WWo5WExiSFlENjlTc0JIMWU2dXluRTV4anRIRGVY?=
 =?utf-8?B?c3hvUmwyRmNEZTFqZlltZlNQOHpGNENFVXdRYndpamRMQmlIQ2g5MTZQS1hB?=
 =?utf-8?B?K2RDaFRIUDB0SUxuOGpmOGdhQ0MwUWlGMDZMVlFCVEl0OHZWVGFwM3pWeGpX?=
 =?utf-8?B?RnZCTWxCNzhFWS84bWY3a3NLalMxa3dwNm90c0NmVzM4WGNhUGhhTWtwWmtJ?=
 =?utf-8?B?QmZVUHNlZXRpZENDdEpGWU1GanlIamhVL1Vkb1VQck5XdG9zSGwxQTFuRjV3?=
 =?utf-8?B?YkZsaFBmREl2MkNPbE5lalpTUDJrQ3ZwL01uQXhMUzBMejN2cFBSMDBxUk1I?=
 =?utf-8?B?K1BlaWpXQWZ2endkUkNiVzdqc2xpbjZ2a0s2ZDk5cUJZcDdDZWs1cWZTcWlK?=
 =?utf-8?B?OStnWmJNWHA4WnUzOGRhZ0lBS3hkUitnSmc4eXIzeStmU2wrM3RQMnNmR3Yz?=
 =?utf-8?B?di9qaGE3NCt5R1dJYVdTdkZ6bHR1V2gwZ0xwVURHM0lqclZDeGRRTlBFZjVy?=
 =?utf-8?B?YnlmTGNuUCs2RVB5aWxOcEZjM1V0MzFaSi9XN05kdWFNTTlTU0hiL3FDdlo4?=
 =?utf-8?B?WXZRYVpwZEVoWk85WmJ0cVRKWlp3MFlmYmh6WVFQaWRyMzIzWjhTNFZRSkMw?=
 =?utf-8?B?TlNYVnFkZ0NxUWxlbFJFN0ljeGZOOHB5WGJJVnByWWcvN3JjTEIzVDFXQXZi?=
 =?utf-8?Q?sKlV3d?=
X-Microsoft-Antispam-Message-Info: Jg1ytblz69fOE6Eek/oz7zahebJoOlQOvE0G8Dj0pkLPDmUMOeRxCIP8gWEJSII4myGClFXdklO83I7gAsP3ym8gI7cfIUc0r/Ec4iKhkineBqNoaKwGms37bCM+WaMK2Tn5ReiY5VF6QFNEBOvglGQFw3+ueYCQnQByvGXUnz7HItmnPUVwBz+uTpwzpEPj0jrzhosQPJHE/ees99tnFpeOKZSy9VZclvMU1hEcGcrfyki1BcSZIOOd/rXevSH9EfSUBjWxQWEzYklEVIwPFeyY4CMHawFaJ8HrcolQic1saxV/Y2DHPLkiwhKw9I3GTmxl4hZvqQx7iM6XTMtwgItWpk2oOjtZohyZxmkBOe4=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2461;6:LweteNzR7Dk1ZzSy9wd/bQayIw1GbdOVm/zfWGq/nCc7/SPe2XMAZUSRQlRORchtqoPRp9ujio2GZnd1ri3QFqMSEbxfi0VGSFpf/fErbRc6F/RVBPFIxLFuVHMUuXjncE/F1Ebn191AP+q6JhthfD/yLEZZf3P2Q+YeW60+OD526+cPKPL6YhaAKBWYAotHB3V37lyHjWGoNalfbk2YudaULkFMTNLFnYLWBVuMO6cDLNrK8fBzJ+8hmaEwbv9pEKH8/Wmlx29efpmqXjOrTW76eGHuxZkLfFH7lxF7ZV0pJqP4McWeHGi+pyHtSZHZvlxPSrI2foE213YIDI4qO9NybdI+dYceIVdH223pP/W5wLhKn0ZBOxcccya/3bK/vMiG9Z13hC5RECsxsoIPI4tDpUnGy9SvxAq07QFsYhDPkuC132ahBMDUfFuBjnmUvv8A6JZRxDNoD/3jKQ4vOA==;5:J8egtK7Ea8dG8L61iI7s5O4r2fhtjjE8dSoMUmkJ/olt3K8fpR9P/6AHPp0VbEX77Q1TExOL5RSn/qlAJLlnIwkEMwA3Wzs3yA4Am4UO0RBuiDUf2VPqpFo7L1oq0enqjzC9lgeP9BqfTK9A+jYwHQRhpPOvF/z5RiypelvjkjQ=;24:gjh2ssIbQlVwqJFWWTkpLT+ZYEbx7OBD84UgKswsobFe3rLfj22O88iSc7gA3o+pr+vAKYspyZJ/+py57FYmX2Jnaq/6IgYcBioxblAd1bI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2461;7:f3twTe4evt3R1R7P6sUZ4E1gy9vrDgO5ADJm9SxOseyDHAf9GViRIAw06FvqE1F2Wq1UeqCMEAMDKhpSbSTleO+D/ImhmK5E0bHP2/pjfPl1ILhhC8+yIrX47P1CpUB4TkjW0bf9aBibMcU//GW35tlQU4xEZmP1JTx11Si7L/X6lT940yqmhmi2JGKwDQUDLGdeW7Y5ncG2gzes67+tr+IwHfS2Tjj0viIqkQH7Lc0z+lTi+FxbVrbRdw0rDlqU;20:SBpbg1v5SjeZBr5eD9z4/1lokRPgT9cCSq1U478I7pDTQg84+wvWiGLoJwnB6k9JzcuJ6eQi8XV5nO31L5HNQyEw6ZufCqLaatV5JQfMvnKi3BAv4XF2Bv79fVLkGoo5E5jUL1aeX7FV9OharjmN/gXkzpxfRRkEyOdMpXp+XfF2k0ttAwMfJMldVd4tnIAFSz9koK3A9I6iNXe4dN59EhGfMBwbsi4iJJ5ATW6hnOmDnO8Mbn+ehOs2gM9U+Lcu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 16:34:27.3305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd2b2e0-e876-41f4-c8b5-08d5e039addc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 11:30 AM, Janakarajan Natarajan wrote:
> Prevent a config where KVM_AMD=y and CRYPTO_DEV_CCP_DD=m thereby ensuring
> that AMD Secure Processor device driver will be built-in when KVM_AMD is
> also built-in.
> 
> v1->v2:
> * Removed usage of 'imply' Kconfig option.
> * Change patch commit message.
> 
> Fixes: 505c9e94d832 ("KVM: x86: prefer "depends on" to "select" for SEV")
> 
> Cc: <stable@vger.kernel.org> # 4.16.x
> Signed-off-by: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> ---

Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>


>   arch/x86/kvm/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 92fd433..1bbec38 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -85,7 +85,7 @@ config KVM_AMD_SEV
>   	def_bool y
>   	bool "AMD Secure Encrypted Virtualization (SEV) support"
>   	depends on KVM_AMD && X86_64
> -	depends on CRYPTO_DEV_CCP && CRYPTO_DEV_CCP_DD && CRYPTO_DEV_SP_PSP
> +	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>   	---help---
>   	Provides support for launching Encrypted VMs on AMD processors.
>   
> 
